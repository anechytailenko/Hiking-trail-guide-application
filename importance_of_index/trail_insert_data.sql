-- Create the function to insert data for 200,000 rows
USE withoutindex;
DELIMITER //

CREATE PROCEDURE InsertTrailData4()
BEGIN
    DECLARE i INT DEFAULT 0;

    WHILE i < 200000 DO
            INSERT INTO trail (trail_name, length, elevation, description, image, location_id)
            VALUES (
                       CONCAT('Trail ', i),
                       ROUND(RAND() * 30 + 1, 2), -- Random length between 1 and 31 miles
                       ROUND(RAND() * 5000 + 100, 2), -- Random elevation between 100 and 5100 feet
                       CONCAT('Description for Trail ', i),
                       CONCAT('image_', i, '.jpg'),
                       FLOOR(1 + RAND() * (SELECT MAX(id) FROM location)) -- Random location_id
                   );
            SET i = i + 1;
        END WHILE;
END //
DELIMITER ;

-- Call the function to insert data
CALL InsertTrailData4();
