USE hiking_trail_guide_app;
CREATE TABLE location(
                         id INT NOT NULL AUTO_INCREMENT,
                         location_name VARCHAR(255),
                         country VARCHAR(255),
                         region VARCHAR(255),
                         coordinate POINT,
                         PRIMARY KEY (id)
);
CREATE TABLE difficulty (
                            id INT NOT NULL AUTO_INCREMENT,
                            level ENUM('easy','moderate','hard'),
                            description VARCHAR(255),
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

CREATE TABLE hiker (
                       id INT NOT NULL AUTO_INCREMENT,
                       visitor_name VARCHAR(255),
                       email VARCHAR(255),
                       pass VARCHAR(255),
                       p_type ENUM('noob','moderate','pro'),
                       UNIQUE(email),
                       PRIMARY KEY(id)
);
CREATE TABLE rating(
                       id INT NOT NULL AUTO_INCREMENT,
                       score INT,
                       hiker_id INT,
                       trail_id INT,
                       difficulty_id INT,
                       PRIMARY KEY(id),
                       CONSTRAINT FK_hiker_id_1 FOREIGN KEY (hiker_id) REFERENCES hiker(id),
                       CONSTRAINT FK_trail_id_1 FOREIGN KEY (trail_id) REFERENCES trail(id),
                       CONSTRAINT FK_difficulty_id_1 FOREIGN KEY (difficulty_id) REFERENCES difficulty(id),
                       CONSTRAINT CHK_score CHECK (score BETWEEN 1 and 10)
);
CREATE TABLE review (
                        id INT NOT NULL AUTO_INCREMENT,
                        title VARCHAR(255),
                        content VARCHAR(255),
                        review_date date,
                        hiker_id INT,
                        trail_id INT,
                        PRIMARY KEY (id),
                        CONSTRAINT FK_hiker_id_2 FOREIGN KEY (hiker_id) REFERENCES hiker(id),
                        CONSTRAINT FK_trail_id_2 FOREIGN KEY (trail_id) REFERENCES trail(id)
);