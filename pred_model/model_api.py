from fastapi import FastAPI
from pydantic import BaseModel
from eval_model import predict

app = FastAPI()

# Define the request body model
class EvaluationRequest(BaseModel):
    question: str
    ideal_answer: str
    subjective_answer: str
    weightage: float

@app.post("/evaluate")
def evaluate_answer(data: EvaluationRequest):
    result = predict(
        question=data.question,
        ideal_answer=data.ideal_answer,
        subjective_answer=data.subjective_answer,
        weightage=data.weightage
    )
    return result