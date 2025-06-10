import requests

# Define the URL of the API endpoint
url = "http://localhost:4000/evaluate"

# Define the data payload (same as your curl JSON)
payload = {
    "question": ["What is AI?","What is supervised machine learning?"],
    "ideal_answer": ["Artificial Intelligence is the simulation of human intelligence by machines.","Supervised machine learning is a fundamental type of machine learning where an algorithm learns from labeled data."],
    "subjective_answer": ["AI is when machines act like humans.","It is an approach to machine learning that involves learning from labeled information"],
    "weightage": [5,5]
}

# Set the headers
headers = {
    "Content-Type": "application/json"
}

# Send the POST request
response = requests.post(url, json=payload, headers=headers)

# Print the response
print("Status Code:", response.status_code)
print("Response Body:", response.json())
