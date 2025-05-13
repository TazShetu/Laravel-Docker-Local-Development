FROM php:8.4-fpm-alpine

# Install essential dependencies only
RUN apk add --no-cache \
    git \
    zip \
    unzip \
    libzip-dev \
    oniguruma-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    $PHPIZE_DEPS

# Install only required PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    pdo_mysql \
    zip \
    bcmath \
    gd \
    opcache

# Install composer with optimizations
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configure opcache for production
RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

# Configure PHP settings
RUN echo "memory_limit=256M" > /usr/local/etc/php/conf.d/memory-limit.ini \
    && echo "upload_max_filesize=32M" > /usr/local/etc/php/conf.d/upload-limit.ini \
    && echo "post_max_size=32M" >> /usr/local/etc/php/conf.d/upload-limit.ini

WORKDIR /app

EXPOSE 8000

# CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]