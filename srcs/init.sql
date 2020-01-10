CREATE USER 'Admin-sys'@'localhost' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON * . * TO 'Admin-sys'@'localhost';
FLUSH PRIVILEGES;
CREATE DATABASE wordpress;
quit
