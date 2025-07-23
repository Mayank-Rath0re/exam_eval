from google import genai
import sys
client = genai.Client(api_key="AIzaSyCyc-ULVP7NPuVufL8NRkJYvrQr_X19-Cc")

#search api key AIzaSyDon3x9TilBfFa-2UDqstS44qeKP9OpOA0

file = sys.argv[1]
myfile = client.files.upload(file=file)

result = client.models.generate_content(
    model="gemini-2.5-flash",
    contents=[
        myfile,
        "\n\n",
        "Return the text written in this image",
    ],
)

response = client.models.generate_content(
    model="gemini-2.5-flash", contents=f"Implement autocorrect on this to fix the spell errors according to the context and return the corrected text only: {result.text}"
        )


print(response.text)