# FROM php:8.3-cli

# RUN docker-php-ext-install pdo_sqlite

# WORKDIR /app
# COPY . .
# RUN mkdir -p /app/data && chmod 777 /app/data

# ENV PORT=3000
# ENV DATABASE_PATH=/app/data/locker.db
# EXPOSE 3000

# CMD ["sh", "-c", "php -S 0.0.0.0:${PORT} -t public public/router.php"]


FROM php:8.3-cli

# 1. Install necessary system dependencies for pdo_sqlite
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Compile and install the extension
RUN docker-php-ext-install pdo_sqlite

WORKDIR /app

# 3. Copy application files
COPY . .

# 4. Set up the data directory for the SQLite database
RUN mkdir -p /app/data && chmod 777 /app/data

ENV PORT=3000
ENV DATABASE_PATH=/app/data/locker.db
EXPOSE 3000

# 5. Serve the application
CMD ["sh", "-c", "php -S 0.0.0.0:${PORT} -t public public/router.php"]
