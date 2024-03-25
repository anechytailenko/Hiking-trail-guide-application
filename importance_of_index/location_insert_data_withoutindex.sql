-- Create the location table
USE withoutindex
CREATE TABLE IF NOT EXISTS location (
                                        id INT NOT NULL AUTO_INCREMENT,
                                        location_name VARCHAR(255),
                                        country VARCHAR(255),
                                        region VARCHAR(255),
                                        coordinate POINT,
                                        PRIMARY KEY (id)
);

-- Generate 200,000 rows
DELIMITER //
CREATE PROCEDURE GenerateLocations2()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE location_name VARCHAR(255);
    DECLARE country VARCHAR(255);
    DECLARE region VARCHAR(255);
    DECLARE lat DECIMAL(10, 8);
    DECLARE lon DECIMAL(11, 8);

    WHILE i < 200000 DO
            SET location_name = CONCAT('Location ', i);
            SET country = CONCAT('Country ', FLOOR(1 + RAND() * 10));
            SET region = CONCAT('Region ', FLOOR(1 + RAND() * 5));
            SET lat = RAND() * 180 - 90;
            SET lon = RAND() * 360 - 180;

            INSERT INTO location (location_name, country, region, coordinate)
            VALUES (location_name, country, region, POINT(lat, lon));

            SET i = i + 1;
        END WHILE;
END //
DELIMITER ;

-- Call the procedure to generate locations
CALL GenerateLocations2();




