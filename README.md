# Laravel Docker Local Development (Multi-Project or Micro Service)

## Prerequisites
- Docker
- Docker Compose

## Setup
1. Place Laravel projects in `projects/` directory
2. Make scripts executable: 
   ```bash
   chmod +x docker-scripts/start-project.sh
   chmod +x docker-scripts/stop-project.sh
3. Copy docker-entrypoint.sh to each Laravel projects: 
   ```bash
   cp docker-entrypoint.sh projects/project1/
   cp docker-entrypoint.sh projects/project2/
# Project Configuration Requirements
- Each project needs a `docker-entrypoint.sh`
- Configure `.env` to use shared MySQL:

- DB_HOST=mysql #Service Name
- DB_PORT=3306
- DB_DATABASE=project1_database  # Unique per project
- DB_USERNAME=root
- DB_PASSWORD=qwerty
- Create DB from phpmyadmin
- Run command like 
```
docker exec -it project1-app(container_name) php artisan migrate:fresh --seed --force
```

#
# Running Multiple Projects Simultaneously

## Start project1 on port 8001
   ```
   Linux or WSL
   ./docker-scripts/start-project.sh project1
   Command Prompt
   docker-scripts\start-project.bat project1
   PowerShell or Warp
   .\docker-scripts\start-project.ps1 project1
   ```

## Start project2 on port 8002
   ```
   Linux or WSL
   ./docker-scripts/start-project.sh project2
   Command Prompt
   docker-scripts\start-project.bat project2
   PowerShell or Warp
   .\docker-scripts\start-project.ps1 project2
   ```

## Stop project1
   ```
   Linux or WSL
   ./docker-scripts/stop-project.sh project1
   Command Prompt
   docker-scripts\stop-project.bat project1
   PowerShell or Warp
   .\docker-scripts\stop-project.ps1 project1
   ```

## Stop project2
   ```
   Linux or WSL
   ./docker-scripts/stop-project.sh project2
   Command Prompt
   docker-scripts\stop-project.bat project2
   PowerShell or Warp
   .\docker-scripts\stop-project.ps1 project2
   ```

# Accessing Projects

- Project 1: http://localhost:8001
- Project 2: http://localhost:8002
- phpMyAdmin: http://localhost:8080
- Shared MySQL: localhost:3316

# Detailed Explanation

### How This Works
1. Base `docker-compose.yml` contains shared services (MySQL, phpMyAdmin)
2. `docker-compose.override.yml` defines project-specific services
3. Scripts help manage starting/stopping individual projects
4. Each project runs on a different port (8001, 8002)
5. Shared MySQL instance used across all projects

### Key Benefits
- Run multiple Laravel projects simultaneously
- Consistent port mapping
- Easy project management
- Minimal resource consumption
- Shared database service

## Additional Considerations
- Ensure unique database names
- Scripts work on Unix-like systems
- For Windows, use Git Bash or WSL

#
# Typical Workflow

- Place project in projects directory/folder
- Add that project in docker-compose.override.yml accordingly
- Copy docker-entrypoint.sh to the project directory/folder
- Edit .env accordingly [DB Connection]
- Add database using phpmyadmin
- Run migration seed command
- Run start/stop scripts