#!/bin/bash

# Check if a project name is provided
if [ $# -eq 0 ]; then
    echo "Usage: ./start-project.sh <project_name>"
    echo "Available projects:"
    ls projects/
    exit 1
fi

PROJECT_NAME=$1

# Validate project exists
if [ ! -d "projects/$PROJECT_NAME" ]; then
    echo "Project '$PROJECT_NAME' does not exist."
    exit 1
fi

# Choose appropriate service name based on project
case "$PROJECT_NAME" in
    project1)
        SERVICE_NAME=app1
        PORT_NUMBER=8001
        ;;
    # project3)
    #     SERVICE_NAME=app3
    #     PORT_NUMBER=8003
    #     ;;
    project2)
        SERVICE_NAME=app2
        PORT_NUMBER=8002
        ;;
    *)
        echo "Unsupported project: $PROJECT_NAME"
        exit 1
        ;;
esac

# Start base services and specific project service
docker-compose up -d mysql phpmyadmin
docker-compose up -d $SERVICE_NAME

echo "Started $PROJECT_NAME on http://localhost:$(docker-compose port $SERVICE_NAME $PORT_NUMBER | cut -d: -f2)"
