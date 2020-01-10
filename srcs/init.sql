CREATE USER 'Admin-sys'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON * . * TO 'Admin-sys'@'%';
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER 'utilisateur'@'localhost' IDENTIFIED BY 'mot de passe';
GRANT ALL PRIVILEGES ON wordpress . * TO 'utilisateur'@'localhost';
FLUSH PRIVILEGES;
quit
