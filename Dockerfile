# Some important docker commands
# docker
# docker version
# docker help
# docker ps -> list all running containers
# docker ps -a -> list all containers (running and stopped)








# docker run -d --name <container_name> <image_name> -> run a container in detached mode
# docker stop <container_name> -> stop a container
# docker start <container_name> -> start a container
# docker exec -it <container_name> /bin/bash -> execute a command in a container
# docker logs <container_name> -> view logs of a container
# docker rm <container_name> -> remove a container
# docker rmi <image_name> -> remove an image
# docker build -t <image_name> . -> build an image
# docker run -d --name <container_name> -p <host_port>:<container_port> <image_name> -> run a container in detached mode and map ports


# Dockerfile is required to create dockerimage
# Docker image is a snapshot or docker container compatible instruction
# Docker container is a linux based environment

# Use official Python image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set workdir
WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y build-essential poppler-utils && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Copy project files
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port
EXPOSE 8080

# Run FastAPI with uvicorn
#CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8080", "--reload"]

# Replace last CMD in prod
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8080", "--workers", "4"]