@echo off
setlocal enabledelayedexpansion

:: Check if a project name is provided
if "%~1"=="" (
    echo Usage: start-project.bat ^<project_name^>
    echo Available projects:
    for /d %%d in (projects\*) do (
        echo   - %%~nd
    )
    exit /b 1
)

set PROJECT_NAME=%~1

:: Check if the project exists
if not exist "projects\%PROJECT_NAME%" (
    echo Project '%PROJECT_NAME%' does not exist.
    exit /b 1
)

:: Choose appropriate service name based on project
if "%PROJECT_NAME%"=="project1" (
    set SERVICE_NAME=app1
) else if "%PROJECT_NAME%"=="project2" (
    set SERVICE_NAME=app2
) else (
    echo Unsupported project: %PROJECT_NAME%
    exit /b 1
)

:: Start base services and specific project service
echo Starting MySQL and phpMyAdmin...
docker-compose up -d mysql phpmyadmin

echo Starting %PROJECT_NAME%...
docker-compose up -d %SERVICE_NAME%

:: Get the port
set PORT=8001
if "%SERVICE_NAME%"=="app2" set PORT=8002

echo Started %PROJECT_NAME% on http://localhost:%PORT%