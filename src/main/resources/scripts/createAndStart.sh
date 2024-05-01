#!/bin/bash

# Check if port and container name are provided as arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <port> <container_name>"
    exit 1
fi

# Assign arguments to variables
port=$1
container_name=$2

# Generate Dockerfile content
dockerfile_content="FROM openjdk:21-ea-30-slim-bookworm\n\nCOPY build/libs/eureka-*-SNAPSHOT.jar app.jar\n\nENTRYPOINT [\"java\", \"-jar\", \"/app.jar\"]"

# Write Dockerfile
echo -e "$dockerfile_content" > Dockerfile

# Generate docker-compose.yml content
docker_compose_content="services:\n  $container_name:\n    container_name: $container_name\n    build:\n      context: .\n      dockerfile: Dockerfile\n    environment:\n      serverPort: $port\n    ports:\n      - \"$port: $port\""

# Write docker-compose.yml
echo -e "$docker_compose_content" > docker-compose.yml

# Start container using docker-compose
docker compose up -d

# Delete docker-compose.yml
rm docker-compose.yml
rm Dockerfile

echo "Container $container_name started with port $port and docker-compose file deleted."
