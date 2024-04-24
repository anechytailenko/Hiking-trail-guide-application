-- Assuming you have already created the `trail` table structure

-- Generate 60 rows of specific data
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

-- Call the procedure to generate specific data
CALL GenerateSpecificTrailsDatassss();
