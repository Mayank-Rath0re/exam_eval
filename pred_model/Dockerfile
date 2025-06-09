# Use an official Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install dependencies (including OpenJDK 17)
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN python -c "import language_tool_python; language_tool_python.LanguageTool('en-US')"

# Download necessary NLTK data
RUN python -m nltk.downloader punkt stopwords

# Copy the rest of the application
COPY . .

# Expose the FastAPI server port
EXPOSE 4000

# Start the FastAPI server
CMD ["uvicorn", "model_api:app", "--host", "0.0.0.0", "--port", "4000"]
