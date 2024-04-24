-- Assuming you have already created the `hiker` table structure

-- Generate 80 rows of data
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

-- Call the procedure to generate data
CALL GenerateHikerData();
