docker build -t my-lamp-wordpress-image .
docker run -p 8080:80 -p 33060:3306 --name my-lamp-wordpress-container -d my-lamp-wordpress-image
