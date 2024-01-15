docker build -t my-lamp-wordpress-image .
docker run -p 80:80 -p 443:443 -p 33060:3306 --name my-lamp-wordpress-container -d my-lamp-wordpress-image
