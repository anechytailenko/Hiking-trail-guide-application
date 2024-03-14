USE hiking_hope_finally;
CREATE TABLE location(
    id INT NOT NULL AUTO_INCREMENT,
    country VARCHAR(255),
    coordinate POINT,
    PRIMARY KEY (id)              
);
CREATE TABLE difficulty (
                            id INT NOT NULL AUTO_INCREMENT,
                            level INT,
                            description VARCHAR(255),
                            PRIMARY KEY (id)
);
CREATE TABLE trail(
    id INT NOT NULL AUTO_INCREMENT,
    elevation DOUBLE(50,2),
    length DOUBLE(50,2),
    description VARCHAR(255),
    image VARCHAR(255),
    id_location INT,
    id_difficulty INT,
    PRIMARY KEY (id) ,
    CONSTRAINT FK_id_location_1 FOREIGN KEY(id_location) REFERENCES location(id),
    CONSTRAINT FK_id_difficulty_1 FOREIGN KEY(id_difficulty) REFERENCES difficulty(id)
);

CREATE TABLE hiker (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255),
    pass VARCHAR(255),
    p_type ENUM('noob','moderate','pro'),
    UNIQUE(email),
    PRIMARY KEY(id)           
);
CREATE TABLE rating(
                       id INT NOT NULL AUTO_INCREMENT,
                       score INT,
                       PRIMARY KEY(id),
                       CHECK (score BETWEEN 0 and 10)
);
CREATE TABLE review (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    content VARCHAR(255),
    review_date date,
    id_hiker INT,
    id_rating INT,
    id_trail_ INT,
    PRIMARY KEY (id),
    CONSTRAINT FK_id_trail_1 FOREIGN KEY (id_trail_) REFERENCES trail(id),
    CONSTRAINT FK_id_hiker_1 FOREIGN KEY (id_hiker) REFERENCES hiker(id),
    CONSTRAINT FK_id_rating_1 FOREIGN KEY (id_rating) REFERENCES rating(id)                 
);

