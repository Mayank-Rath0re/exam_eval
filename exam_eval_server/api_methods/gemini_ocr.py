from google import genai
import sys
client = genai.Client(api_key="AIzaSyCyc-ULVP7NPuVufL8NRkJYvrQr_X19-Cc")

file = sys.argv[1]
myfile = client.files.upload(file=file)
print(f"{myfile=}")

result = client.models.generate_content(
    model="gemini-2.0-flash",
    contents=[
        myfile,
        "\n\n",
        "Return the text written in this image",
    ],
)

response = client.models.generate_content(
    model="gemini-2.0-flash", contents=f"Implement autocorrect on this to fix the spell errors according to the context and return the corrected text only: {result.text}"
        )


print(response.text)