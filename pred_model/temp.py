from eval_model import predict

# Define the data payload (same as your curl JSON)
question = ["What is AI?","What is supervised machine learning?"]
ideal_answer = ["Artificial Intelligence is the simulation of human intelligence by machines.","Supervised machine learning is a fundamental type of machine learning where an algorithm learns from labeled data."]
subjective_answer = ["AI is when machines act like humans.","It is an approach to machine learning that involves learning from labeled information"]
weightage = [5,5]

result = predict(questionList=question, idealAnswerList=ideal_answer, subjectiveAnswerList=subjective_answer, weightageList=weightage)

print(result)