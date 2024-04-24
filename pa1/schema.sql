-- Creation od database
CREATE DATABASE hiking_trail_guide_app;
-- Creation of tables
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

-- Insert data in our tables
-- table trail
DELIMITER //
CREATE PROCEDURE GenerateSpecificTrailsDatassss()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE trail_name VARCHAR(255);
    DECLARE length DOUBLE(50,2);
    DECLARE elevation DOUBLE(50,2);
    DECLARE description VARCHAR(255);
    DECLARE image VARCHAR(255);
    DECLARE location_id INT;

    WHILE i < 60 DO
            SET trail_name = CONCAT('Trail_', i+1, '_in_', (SELECT location_name FROM location WHERE id = ((i % 40) + 1)));
            SET length = ROUND(RAND() * 20 + 1, 2); -- Length between 1 and 21 miles
            SET elevation = ROUND(RAND() * 5000, 2); -- Elevation between 0 and 5000 feet
            SET description = CONCAT('Description of Trail ', i+1, ' in ', (SELECT country FROM location WHERE id = ((i % 40) + 1)));
            SET image = CONCAT('image_', i+1, '.jpg');
            SET location_id = ((i % 40) + 1); -- Assuming location IDs start from 1

            INSERT INTO trail (trail_name, length, elevation, description, image, location_id)
            VALUES (trail_name, length, elevation, description, image, location_id);

            SET i = i + 1;
        END WHILE;
END//
DELIMITER ;
CALL GenerateSpecificTrailsDatassss();
-- table review
DELIMITER //
CREATE PROCEDURE GenerateReviewData()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE title VARCHAR(255);
    DECLARE content VARCHAR(255);
    DECLARE review_date DATE;
    DECLARE hiker_id INT;
    DECLARE trail_id INT;

    WHILE i < 100 DO
            SET title = CONCAT('Review_', i+1); -- Unique title for each review
            SET content = CONCAT('Content of Review ', i+1); -- Unique content for each review
            SET review_date = DATE_SUB(CURRENT_DATE(), INTERVAL i DAY); -- Review dates vary by days from the current date
            SET hiker_id = FLOOR(RAND() * 80) + 1; -- Random hiker_id between 1 and 80
            SET trail_id = FLOOR(RAND() * 60) + 1; -- Random trail_id between 1 and 60

            INSERT INTO review (title, content, review_date, hiker_id, trail_id)
            VALUES (title, content, review_date, hiker_id, trail_id);

            SET i = i + 1;
        END WHILE;
END//
DELIMITER ;
CALL GenerateReviewData();
-- table rating
DELIMITER //
CREATE PROCEDURE GenerateRatingsDatasss()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE score INT;
    DECLARE hiker_id INT;
    DECLARE trail_id INT;
    DECLARE difficulty_id INT;

    WHILE i < 100 DO
            SET score = FLOOR(RAND() * 10) + 1; -- Random score between 1 and 10
            SET hiker_id = FLOOR(RAND() * 80) + 1; -- Random hiker_id between 1 and 80
            SET trail_id = FLOOR(RAND() * 60) + 1; -- Random trail_id between 1 and 60
            SET difficulty_id = FLOOR(RAND() * 40) + 1; -- Random difficulty_id between 1 and 40

            INSERT INTO rating (score, hiker_id, trail_id, difficulty_id)
            VALUES (score, hiker_id, trail_id, difficulty_id);

            SET i = i + 1;
        END WHILE;
END//
DELIMITER ;
CALL GenerateRatingsDatasss();
-- table location
DELIMITER //
CREATE PROCEDURE GenerateExpandedLocationData()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE loc_name VARCHAR(255);
    DECLARE cntry VARCHAR(255);
    DECLARE regn VARCHAR(255);
    DECLARE lat DECIMAL(9,6);
    DECLARE lon DECIMAL(9,6);

    WHILE i < 40 DO
            SET loc_name = CONCAT('Location_', i+1);
            SET cntry = CASE FLOOR(RAND() * 6)
                            WHEN 0 THEN 'United States'
                            WHEN 1 THEN 'Canada'
                            WHEN 2 THEN 'Australia'
                            WHEN 3 THEN 'United Kingdom'
                            WHEN 4 THEN 'Germany'
                            ELSE 'Japan'
                END;
            SET regn = CASE cntry
                           WHEN 'United States' THEN
                               CASE FLOOR(RAND() * 3)
                                   WHEN 0 THEN 'West Coast'
                                   WHEN 1 THEN 'East Coast'
                                   ELSE 'Midwest'
                                   END
                           WHEN 'Canada' THEN
                               CASE FLOOR(RAND() * 3)
                                   WHEN 0 THEN 'Ontario'
                                   WHEN 1 THEN 'British Columbia'
                                   ELSE 'Alberta'
                                   END
                           WHEN 'Australia' THEN
                               CASE FLOOR(RAND() * 3)
                                   WHEN 0 THEN 'New South Wales'
                                   WHEN 1 THEN 'Victoria'
                                   ELSE 'Queensland'
                                   END
                           WHEN 'United Kingdom' THEN
                               CASE FLOOR(RAND() * 3)
                                   WHEN 0 THEN 'England'
                                   WHEN 1 THEN 'Scotland'
                                   ELSE 'Wales'
                                   END
                           WHEN 'Germany' THEN
                               CASE FLOOR(RAND() * 3)
                                   WHEN 0 THEN 'Bavaria'
                                   WHEN 1 THEN 'North Rhine-Westphalia'
                                   ELSE 'Baden-Württemberg'
                                   END
                           ELSE
                               CASE FLOOR(RAND() * 3)
                                   WHEN 0 THEN 'Kanto'
                                   WHEN 1 THEN 'Kansai'
                                   ELSE 'Chubu'
                                   END
                END;
            SET lat = RAND() * 180 - 90; -- Latitude range: -90 to 90
            SET lon = RAND() * 360 - 180; -- Longitude range: -180 to 180

            INSERT INTO location (location_name, country, region, coordinate)
            VALUES (loc_name, cntry, regn, POINT(lat, lon));

            SET i = i + 1;
        END WHILE;
END//
DELIMITER ;
CALL GenerateExpandedLocationData();
-- table hiker
DELIMITER //
CREATE PROCEDURE GenerateHikerData()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE visitor_name VARCHAR(255);
    DECLARE email VARCHAR(255);
    DECLARE pass VARCHAR(255);
    DECLARE p_type ENUM('noob', 'moderate', 'pro');

    WHILE i < 80 DO
            SET visitor_name = CONCAT('Hiker_', i+1);
            SET email = CONCAT('hiker', i+1, '@example.com');
            SET pass = CONCAT('password', i+1);
            SET p_type = CASE FLOOR(RAND() * 3)
                             WHEN 0 THEN 'noob'
                             WHEN 1 THEN 'moderate'
                             ELSE 'pro'
                END;

            INSERT INTO hiker (visitor_name, email, pass, p_type)
            VALUES (visitor_name, email, pass, p_type);

            SET i = i + 1;
        END WHILE;
END//
DELIMITER ;
CALL GenerateHikerData();
-- table difficulty
DELIMITER //
CREATE PROCEDURE GenerateDifficultyData()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE level_enum VARCHAR(8);
    DECLARE descriptions VARCHAR(255);

    WHILE i < 40 DO
            SET level_enum = CASE FLOOR(RAND() * 3)
                                 WHEN 0 THEN 'easy'
                                 WHEN 1 THEN 'moderate'
                                 ELSE 'hard'
                END;

            SET descriptions = CASE level_enum
                                   WHEN 'easy' THEN 'Suitable for beginners and families. Generally flat terrain with minimal obstacles.'
                                   WHEN 'moderate' THEN 'Suitable for moderately experienced hikers. May include some elevation gain and rough terrain.'
                                   ELSE 'Suitable for experienced hikers. Often includes steep inclines, rugged terrain, and potentially hazardous conditions.'
                END;

            INSERT INTO difficulty (level, description) VALUES (level_enum, descriptions);

            SET i = i + 1;
        END WHILE;
END//
DELIMITER ;
CALL GenerateDifficultyData();








