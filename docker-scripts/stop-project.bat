@echo off
setlocal enabledelayedexpansion

:: Check if a project name is provided
if "%~1"=="" (
    echo Usage: stop-project.bat ^<project_name^>
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
)
:: else if "%PROJECT_NAME%"=="project3" (
::     set SERVICE_NAME=app3
:: ) 
else (
    echo Unsupported project: %PROJECT_NAME%
    exit /b 1
)

:: Stop specific project service
echo Stopping %PROJECT_NAME%...
docker-compose stop %SERVICE_NAME%

echo Stopped %PROJECT_NAME% successfully