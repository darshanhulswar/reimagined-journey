# Use the official Python base image from the Docker Hub
FROM python:3.9-slim

# Set environment variables to prevent .pyc files and buffer output
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt to the container's /app directory
COPY requirements.txt /app/

# Install the dependencies inside the container
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project files to the container
COPY . /app/

# Expose the port the app will run on (Django's default port is 8000)
EXPOSE 8000

# Run the Django development server (for development purposes)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

