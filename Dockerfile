# Use an official CentOS image as the base image
FROM centos:latest

# Install essential packages
RUN yum -y update && \
    yum -y install httpd \
    mariadb-server \
    mariadb \
    php \
    php-mysql \
    php-gd \
    php-curl \
    php-xml \
    unzip \
    && yum clean all

# Start Apache and MySQL services
RUN systemctl enable httpd && systemctl enable mariadb

# Set up MySQL root password and create WordPress database
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=wordpress
ENV MYSQL_USER=wordpress_user
ENV MYSQL_PASSWORD=wordpress_password

# Install EPEL repository and PHPMyAdmin
RUN yum -y install epel-release && \
    yum -y install phpmyadmin

# Copy the WordPress code into the container
COPY ./wordpress /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Expose ports for web and MySQL
EXPOSE 80
EXPOSE 443
EXPOSE 3306

# Start services
CMD systemctl start mariadb && systemctl start httpd && systemctl status httpd && /bin/bash