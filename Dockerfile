# Use an official Ubuntu image as the base image
FROM ubuntu:latest

# Set noninteractive mode for apt-get to avoid prompts during the build
ARG DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    apache2 \
    mysql-server \
    php \
    libapache2-mod-php \
    php-mysql \
    php-gd \
    php-curl \
    php-xml \
    && rm -rf /var/lib/apt/lists/*

# Configure Apache
RUN a2enmod rewrite

# Set up MySQL root password and create WordPress database
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=wordpress
ENV MYSQL_USER=wordpress_user
ENV MYSQL_PASSWORD=wordpress_password

# Copy the WordPress code into the container
COPY ./wordpress /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Expose ports for web and MySQL
EXPOSE 80
EXPOSE 3306

# Start services
CMD service mysql start && apache2ctl -D FOREGROUND