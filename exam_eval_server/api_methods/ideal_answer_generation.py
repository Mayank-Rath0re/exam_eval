from google import genai
import sys
client = genai.Client(api_key="AIzaSyCyc-ULVP7NPuVufL8NRkJYvrQr_X19-Cc")

query = sys.argv[1]

result = client.models.generate_content(
    model="gemini-2.0-flash",
    contents= f"Return the answer for this query only: {query}",
)
print(result.text)