# PowerShell script to stop a Laravel project
param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName
)

# Check if project exists
if (-not (Test-Path "projects\$ProjectName")) {
    Write-Host "Project '$ProjectName' does not exist in the projects directory." -ForegroundColor Red
    Write-Host "Available projects:"
    Get-ChildItem -Path "projects" -Directory | ForEach-Object { Write-Host "  - $($_.Name)" }
    exit 1
}

# Choose appropriate service name based on project
switch ($ProjectName) {
    "project1" { $ServiceName = "app1" }
    "project2" { $ServiceName = "app2" }
    # "project3" { $ServiceName = "app3" }
    default {
        Write-Host "Unsupported project: $ProjectName" -ForegroundColor Red
        exit 1
    }
}

# Stop specific project service
Write-Host "Stopping $ProjectName..." -ForegroundColor Cyan
docker-compose stop $ServiceName

Write-Host "Stopped $ProjectName successfully" -ForegroundColor Green