# Use an official Python base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN python -m nltk.downloader punkt stopwords

# Copy the rest of the application
COPY . .

# Expose port (same as FastAPI server)
EXPOSE 8000

# Start the FastAPI server
CMD ["uvicorn", "model_api:app", "--host", "0.0.0.0", "--port", "8000"]
