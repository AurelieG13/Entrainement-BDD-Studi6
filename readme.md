# Aide à l'implémentation de la base de données
## Sauvegarder / Restaurer la base de données MySQL
## Sauvegarder la base de données

1. Dans une invite de commande
    1. Se rendre dans le dossier comportant C:/XAMPP/mysql/bin/mysqldump.exe

    2. Utiliser la commande ci dessous pour effectuer la sauvegarde
        >`mysqldump -u root -p cinema>saveCinema.sql`

    3. Le fichier nommé saveCinema.sql a été créé dans le répertoire C:/XAMPP/mysql/bin/   


## Restaurer la base de données
1. En ligne de commande executer

>    `mysql -u root -p`  
>`Enter password:` ->  laisser vide

    Nous accedons au CLI de MariaDB/mysql   

2. Créer la base de données
~~~
CREATE DATABASE IF NOT EXISTS cinema
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
~~~

3. Lancer la commande 
>`use cinema;`
>`source savecinema.sql;`


# Requetes SQL
Pour effectuer toutes les requetes SQL ne pas oublier : 
1. En ligne de commande executer

>    `mysql -u root -p`  
>`Enter password:` ->  laisser vide

    Nous accedons au CLI de MariaDB/mysql   

### Users database
**Créer un nouvel utilisateur**
>CREATE USER 'admin_cinema1'@'localhost' IDENTIFIED BY 'cinema1';
FLUSH PRIVILEGES;

**Ajouter les droits sur l'utilisateur**
>GRANT SELECT ON cinema.* TO 'admin_cinema1'@'localhost' IDENTIFIED BY 'cinema1';
FLUSH PRIVILEGES;

*Pour ajouter les droits sur toutes les tables et toutes les databases remplacer database et table par le caractère `*`*

**Supprimer les droits d'un utilisateur sur la BDD**
>REVOKE TYPE_DE_PERMISSION ON base_de_donnees.table 
FROM ‘nom_utilisateur’@‘localhost’;

**Supprimer un utilisateur**
>DROP USER ‘nom_utilisateur’@‘localhost’;    


### Create database
**Insérer les tables**
```
-- create table
CREATE TABLE means 
(
    id_means INT NOT NULL PRIMARY KEY, 
    name_means VARCHAR(255) NOT NULL
)
ENGINE=InnoDB;

CREATE TABLE mode 
(
    id_mode INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name_mode VARCHAR(255) NOT NULL,
    mode VARCHAR(255) NOT NULL,
    id_means INT NOT NULL,
    FOREIGN KEY (id_means)
        REFERENCES means (id_means)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)
ENGINE=InnoDB;

CREATE TABLE theaters 
(
    id_theater INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name_theater VARCHAR(255) NOT NULL,
    address_theater VARCHAR(255) NOT NULL
)
ENGINE=InnoDB;

CREATE TABLE rooms 
(
    id_room INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    number_room INT NOT NULL,
    ticket_initial INT NOT NULL,
    id_theater INT NOT NULL,
    FOREIGN KEY (id_theater)
        REFERENCES theaters (id_theater)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)
ENGINE=InnoDB;


CREATE TABLE  movies 
(
    id_movie INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name_movie VARCHAR(255) NOT NULL,
    date_movie DATE NOT NULL,
    time_movie INT NOT NULL,
    genre_movie VARCHAR(255) NOT NULL,
    producer_movie VARCHAR(255) NOT NULL,
    synopsis_movie TEXT(3000) NOT NULL
)
ENGINE=InnoDB;

CREATE TABLE users 
(
    id_user INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name_user VARCHAR(255) NOT NULL,
    firstname_user VARCHAR(255) NOT NULL,
    email_user VARCHAR(255) NOT NULL,
    login_user VARCHAR(255) NOT NULL,
    password_user CHAR(60) NOT NULL
)
ENGINE=InnoDB;

CREATE TABLE prices
(
    id_price INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    name_price VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL
)
ENGINE=InnoDB;

CREATE TABLE sessions 
(
    id_session INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    date_session DATE NOT NULL,
    ticket_sold INT NOT NULL,
    ticket_for_sale INT NOT NULL,
    id_theater INT NOT NULL,
    id_movie INT NOT NULL,
    id_price INT NOT NULL,
    id_user INT NOT NULL,
    id_room INT NOT NULL,
    id_mode INT NOT NULL,
    FOREIGN KEY (id_theater)
        REFERENCES theaters (id_theater)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    FOREIGN KEY (id_movie)
        REFERENCES movies (id_movie)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    FOREIGN KEY (id_price)
        REFERENCES prices (id_price)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    FOREIGN KEY (id_user)
        REFERENCES users (id_user)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    FOREIGN KEY (id_room)
        REFERENCES rooms (id_room)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,
    FOREIGN KEY (id_mode)
        REFERENCES mode (id_mode)
        ON DELETE CASCADE
        ON UPDATE NO ACTION
)
ENGINE=InnoDB;

CREATE TABLE session_price (
    id_price INT NOT NULL, 
    id_session INT NOT NULL,
    FOREIGN KEY (id_price)
        REFERENCES prices (id_price),
    FOREIGN KEY (id_session)
        REFERENCES sessions (id_session),
    PRIMARY KEY(id_price, id_session)
)   ENGINE=INNODB;
```

**Ajouter les données factices dans les tables**

Utiliser la section <mark>insert datas</mark> du fichier requetes.sql afin d'importer des données factices dans les tables.



