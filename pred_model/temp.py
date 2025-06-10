from eval_model import predict

# Define the data payload (same as your curl JSON)
question = "What is AI?"
ideal_answer = "Artificial Intelligence is the simulation of human intelligence by machines."
subjective_answer = "AI is when machines act like humans."
weightage = 5

result = predict(question=question, ideal_answer=ideal_answer, subjective_answer=subjective_answer, weightage=weightage)

print(result)