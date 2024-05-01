#!/bin/bash

# Check if container name is provided as argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <containerca_name>"
    exit 1
fi

# Assign arguments to variable
container_name=$1

# Check if the container exists
if [[ "$(docker ps -q -f name=$container_name)" ]]; then
    # Stop the container if it's running
    docker stop $container_name >/dev/null 2>&1

    # Remove the container
    docker rm $container_name >/dev/null 2>&1

    echo "Container stopped and removed successfully."
elif [[ "$(docker ps -aq -f name=$container_name)" ]]; then
    # Remove the container if it's not running but exists
    docker rm $container_name >/dev/null 2>&1

    echo "Container removed successfully."
else
    echo "Container  not found or not running."
fi