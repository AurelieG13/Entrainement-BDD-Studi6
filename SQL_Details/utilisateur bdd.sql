utilisateur bdd

CREATE USER 'admin_cinema1'@'localhost' IDENTIFIED BY 'cinema1';
GRANT SELECT ON cinema.* 
TO 'admin_cinema1'@'localhost'
IDENTIFIED BY 'cinema1';
FLUSH PRIVILEGES;

