#!/bin/bash

# Check if a project name is provided
if [ $# -eq 0 ]; then
    echo "Usage: ./stop-project.sh <project_name>"
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
        ;;
    project2)
        SERVICE_NAME=app2
        ;;
    *)
        echo "Unsupported project: $PROJECT_NAME"
        exit 1
        ;;
esac

# Stop specific project service
docker-compose stop $SERVICE_NAME

echo "Stopped $PROJECT_NAME"