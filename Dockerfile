# Use official Python 3.10 slim image
FROM python:3.10-slim

# Set environment variables to prevent Python from writing .pyc files and buffering stdout
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install OS-level dependencies (for PyPDF, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Copy your app files to the container
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expose the port your app runs on (Fly.io will use 8080 by default)
EXPOSE 8080

# Start the FastAPI app using uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
