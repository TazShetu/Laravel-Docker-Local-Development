# PowerShell script to start a Laravel project
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
    default {
        Write-Host "Unsupported project: $ProjectName" -ForegroundColor Red
        exit 1
    }
}

# Start base services and specific project service
Write-Host "Starting MySQL and phpMyAdmin..." -ForegroundColor Cyan
docker-compose up -d mysql phpmyadmin

Write-Host "Starting $ProjectName..." -ForegroundColor Cyan
docker-compose up -d $ServiceName

# Get the port
$Port = "8001"
if ($ServiceName -eq "app2") {
    $Port = "8002"
}

Write-Host "Started $ProjectName on http://localhost:$Port" -ForegroundColor Green