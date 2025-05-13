#!/bin/sh
set -e

# Check if vendor directory exists (indication of first run)
if [ ! -d "vendor" ]; then
    echo "No vendor folder detected, installing dependencies..."
    composer install
    echo "Running migrations..."
    # Run migrations
    php artisan migrate --seed --force
else
    echo "Dependencies already installed, skipping composer install and migrations. Running application..."
fi

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "No .env file detected, creating .env file from .env.example..."
    cp .env.example .env
    php artisan key:generate
fi

# Start the server
php artisan serve --host=0.0.0.0 --port=8000
