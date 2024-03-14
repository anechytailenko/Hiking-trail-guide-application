CREATE DATABASE withoutindex;
USE withoutindex;
    
CREATE TABLE location(
                         id INT NOT NULL AUTO_INCREMENT,
                         location_name VARCHAR(255),
                         country VARCHAR(255),
                         region VARCHAR(255),
                         coordinate POINT,
                         PRIMARY KEY (id)
);
CREATE TABLE trail(
                      id INT NOT NULL AUTO_INCREMENT,
                      trail_name VARCHAR(255),
                      length DOUBLE(50,2),
                      elevation DOUBLE(50,2),
                      description VARCHAR(255),
                      image VARCHAR(255),
                      location_id INT,
                      PRIMARY KEY (id) ,
                      CONSTRAINT FK_location_id_1 FOREIGN KEY(location_id) REFERENCES location(id)
);

 