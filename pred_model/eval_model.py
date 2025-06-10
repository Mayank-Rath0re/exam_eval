import pandas as pd
import numpy as np
from sklearn.impute import SimpleImputer
from sentence_transformers import SentenceTransformer, util
from sklearn.feature_extraction.text import TfidfVectorizer
import language_tool_python
from gensim import corpora
import spacy
import re
import joblib
from gensim.models import LdaModel
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from fastapi import FastAPI
from typing import List
from pydantic import BaseModel
import json

app = FastAPI()

print("Importing Models")
model = SentenceTransformer('all-MiniLM-L6-v2')
vectorizer = TfidfVectorizer()
tool = language_tool_python.LanguageTool('en-US')
imputer = joblib.load("imputer.pkl")
# Load spaCy model for sentence parsing
nlp = spacy.load("en_core_web_sm")

rf = joblib.load("answer_classifier_model.pkl")

# LDA Model
#Initialize these globally or as part of a class
stop_words = set(stopwords.words('english'))
lda_model = None
dictionary = None

def preprocess_text(text):
    tokens = word_tokenize(text.lower())
    return [word for word in tokens if word.isalpha() and word not in stop_words]

def convert_to_serializable(obj):
    if isinstance(obj, np.ndarray):
        return obj.tolist()
    elif isinstance(obj, (np.generic,)):
        return obj.item()
    raise TypeError(f"Object of type {type(obj)} is not JSON serializable")

# Need to remove this in future and replace with the model file only
def train_lda_model(ideal_answers):
    """Train LDA model on a collection of ideal answers"""
    global lda_model, dictionary
    processed_docs = [preprocess_text(ans) for ans in ideal_answers]
    dictionary = corpora.Dictionary(processed_docs)
    corpus = [dictionary.doc2bow(doc) for doc in processed_docs]
    lda_model = LdaModel(corpus=corpus, id2word=dictionary, num_topics=6, random_state=42, passes=15)

#Analyzing Coherance
def analyze_coherence(text):
    """
    Analyze the coherence of a text based on transition words and entity repetition.
    """
    # List of common transition words
    # Need to be changed in future for better results
    transition_words = [
        "however", "therefore", "in addition", "furthermore", "moreover",
        "on the other hand", "as a result", "consequently", "for example"
    ]

    # Check for transition words
    transitions_found = [word for word in transition_words if word in text.lower()]
    transition_score = len(transitions_found) / len(transition_words)

    # Check for entity repetition (simple example)
    entities = re.findall(r'\b\w+\b', text.lower())  # Extract words
    unique_entities = set(entities)
    entity_repetition_score = len(entities) / len(unique_entities) if unique_entities else 0

    # Combine scores
    coherence_score = (transition_score + entity_repetition_score) / 2

    return coherence_score

#Topic Relevance
def analyze_topic_relevance(question, answer):
    """
    Analyze the topic relevance of an answer to a question.
    """

    # Compute semantic similarity between question and answer
    question_embedding = model.encode(question, convert_to_tensor=True)
    answer_embedding = model.encode(answer, convert_to_tensor=True)
    semantic_similarity = util.cos_sim(question_embedding, answer_embedding).item()

    # Compute keyword overlap using TF-IDF
    tfidf_matrix = vectorizer.fit_transform([question, answer])
    keyword_overlap = (tfidf_matrix * tfidf_matrix.T).toarray()[0, 1]

    # Combine scores
    relevance_score = (semantic_similarity + keyword_overlap) / 2

    return relevance_score

def analyze_sentence_complexity(answer):
    """
    Analyze and return a NORMALIZED sentence complexity score [0-1].
    """
    doc = nlp(answer)
    sentences = list(doc.sents)

    # 1. Normalized Sentence Length (0-1)
    max_length = 30  # Words beyond this don't increase complexity
    avg_length = sum(len(sent) for sent in sentences)/len(sentences) if sentences else 0
    length_score = min(avg_length / max_length, 1.0)

    # 2. Normalized Subordinate Clauses (0-1)
    max_clauses = 5  # More than 5 clauses doesn't mean better
    clauses = sum(1 for sent in sentences
                for token in sent
                if token.dep_ == "mark" and token.text.lower() in ["because", "although", "if", "when"])
    clause_score = min(clauses / max_clauses, 1.0)

    # 3. Normalized Domain Terms (0-1)
    # Need to be changed in future for better performance
    domain_terms = ["data structure", "array", "linked list", "stack", "queue", "tree", "graph"]
    term_count = sum(answer.lower().count(term) for term in domain_terms)
    term_score = min(term_count / len(domain_terms), 1.0)

    # 4. Normalized Sentence Variety (0-1)
    structures = len(set(sent.root.dep_ for sent in sentences)) if sentences else 0
    variety_score = min(structures / 4, 1.0)  # Max 4 different structures

    # Weighted combination
    complexity_score = (
        0.4 * length_score +      # Most important
        0.3 * clause_score +      # Important
        0.2 * term_score +        # Moderately important
        0.1 * variety_score       # Least important
    )

    return min(max(complexity_score, 0), 1)  # Clamp to [0,1]

def analyze_answer_length(answer, ideal_answer, min_percent=0.7, max_percent=1.5):
    """
    Analyze the length of an answer relative to the ideal answer and normalize it to a score between 0 and 1.
    """
    ideal_word_count = len(ideal_answer.split())
    min_words = int(ideal_word_count * min_percent)  # Min length threshold
    max_words = int(ideal_word_count * max_percent)  # Max length threshold

    word_count = len(answer.split())
    if word_count < min_words:
        length_score = word_count / min_words  # Penalize short answers
    elif word_count > max_words:
        length_score = max_words / word_count  # Penalize long answers
    else:
        length_score = 1  # Ideal length
    return length_score

def get_topic_similarity(text1, text2):
    """Calculate cosine similarity between topic distributions of two texts"""
    if lda_model is None:
        raise ValueError("LDA model not trained. Call train_lda_model() first.")

    bow1 = dictionary.doc2bow(preprocess_text(text1))
    bow2 = dictionary.doc2bow(preprocess_text(text2))

    # Get topic distributions
    topics1 = lda_model.get_document_topics(bow1, minimum_probability=0)
    topics2 = lda_model.get_document_topics(bow2, minimum_probability=0)

    # Convert to vectors
    vec1 = np.array([prob for (topic_id, prob) in topics1])
    vec2 = np.array([prob for (topic_id, prob) in topics2])

    # Calculate cosine similarity
    return np.dot(vec1, vec2) / (np.linalg.norm(vec1) * np.linalg.norm(vec2))

def predict_answer_category(final_score,semantic_similarity,keyword_overlap,length_score,relevance_score,coherence_score,topic_similarity):
  # For new data (make sure it has the same features as your training data)
  new_data = pd.DataFrame({
      'Semantic Similarity': [semantic_similarity],  # Pass values as lists
      'Keyword Overlap': [keyword_overlap],
      'Coherence Score': [coherence_score],
      'Topic Relevance': [relevance_score],
      'Answer Length': [length_score],
      'Topic Similarity': [topic_similarity],
      'Final Score': [final_score]
  })

  # Preprocess the new data (same as training)
  new_data_imputed = imputer.transform(new_data)  # Use the same imputer from training

  # Make prediction
  predicted_category = rf.predict(new_data_imputed)
  return predicted_category

def mark_score(weightage,category,final_score):
  if category == "Completly Correct":
    return round((weightage*0.8)+((weightage-weightage*0.8)*final_score))
  elif category == "Partially Correct":
    return round((weightage*0.5)+((weightage*0.7 - weightage*0.5)*final_score))
  elif category == "Incomplete":
    return round((weightage*0.2)+((weightage*0.4 - weightage*0.2)*final_score))
  else:
    return round((weightage*0)+((weightage*0.2 - weightage*0)*final_score))

# Prediction Function
def predict(questionList, idealAnswerList, subjectiveAnswerList,weightageList):
    final_evaluation = []
    """
    Evaluate a subjective answer based on semantic similarity, keyword overlap, grammar, coherence, topic relevance, and specificity.
    """
    print("Training LDA for topic relevance")
    train_lda_model(ideal_answers=idealAnswerList)

    for i in range(len(questionList)):
        question, weightage = questionList[i], weightageList[i]
        ideal_answer, subjective_answer = idealAnswerList[i], subjectiveAnswerList[i]

        # Step 1: Compute Semantic Similarity (between ideal and subjective answers)
        print("Performing Encoding")
        ideal_embedding = model.encode(ideal_answer, convert_to_tensor=True)
        subjective_embedding = model.encode(subjective_answer, convert_to_tensor=True)
        semantic_similarity = util.cos_sim(ideal_embedding, subjective_embedding).item()
        # Step 2: Compute Keyword Overlap (between ideal and subjective answers)
        print("Computing vectors")
        tfidf_matrix = vectorizer.fit_transform([ideal_answer, subjective_answer])
        keyword_overlap = (tfidf_matrix * tfidf_matrix.T).toarray()[0, 1]

        # Step 3: Grammar Checking
        # Use 'en-US' for US English
        print("Grammar Checking")
        matches = tool.check(subjective_answer)
        grammar_score = 1 - (len(matches) / max(len(subjective_answer.split()), 1))  # Normalize by answer length

        # Step 4: Coherence Analysis
        print("Coherence Analysis")
        coherence_score = analyze_coherence(subjective_answer)

        # Step 5: Topic Relevance Analysis
        print("Topic Relevance")
        relevance_score = analyze_topic_relevance(question, subjective_answer)

        #Step 6: Sentence Complexity Analysis
        print("Complexity Analysis")
        complexity_score = analyze_sentence_complexity(subjective_answer)

        #Step 7: ANswer length
        print("Answer Length")
        length_score = analyze_answer_length(subjective_answer, ideal_answer)

        #Step 8: Categorizing answers
        print("Answer Categorization")
        topic_similarity = get_topic_similarity(ideal_answer, subjective_answer)


        # Step 9: Combine Scores (weighted average)
        semantic_weight = 0.3  # Weight for semantic similarity
        keyword_weight = 0.1 # Weight for keyword overlap
        grammar_weight = 0.05   # Weight for grammar score
        coherence_weight = 0.15 # Weight for coherence score
        relevance_weight = 0.15 # Weight for topic relevance
        length_weight = 0.1    # Weight for answer length
        complexity_weight = 0.05 #Weight for Sentence Complexity
        topic_weight = 0.1 #Weight for Topic Similarity
        final_score = (
            (semantic_weight * semantic_similarity) +
            (keyword_weight * keyword_overlap) +
            (grammar_weight * grammar_score) +
            (coherence_weight * coherence_score) +
            (relevance_weight * relevance_score) +
            (complexity_weight * complexity_score) +
            (length_weight * length_score) +
            (topic_weight * topic_similarity)
        )

        #predited category
        category = predict_answer_category(final_score,semantic_similarity,keyword_overlap,length_score,relevance_score,coherence_score,topic_similarity)

        #marking
        marks = mark_score(weightage,category,final_score)

        data = {
            "semantic_similarity": semantic_similarity,
            "keyword_overlap": keyword_overlap,
            "grammar_score": grammar_score,
            "coherence_score": coherence_score,
            "topic_relevance": relevance_score,
            "complexity_score": complexity_score,
            "length_score": length_score,
            "topic_similarity": topic_similarity,
            "final_score": final_score,
            "grammar_errors": [match.ruleId for match in matches],  # List of grammar errors
            "category": category,
            "marks": marks
        }

        final_evaluation.append(data)

    # Serialize to JSON
    json_string = json.dumps(final_evaluation, default=convert_to_serializable)

    return json_string

# Define the request body model
class EvaluationRequest(BaseModel):
    question: List[str]
    ideal_answer: List[str]
    subjective_answer: List[str]
    weightage: List[float]

@app.post("/evaluate")
def evaluate_answer(data: EvaluationRequest):
    result = predict(
        questionList=data.question,
        idealAnswerList=data.ideal_answer,
        subjectiveAnswerList=data.subjective_answer,
        weightageList=data.weightage
    )
    return result