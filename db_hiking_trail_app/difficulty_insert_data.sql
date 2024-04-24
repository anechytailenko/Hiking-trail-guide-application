-- Assuming you have already inserted the `difficulty` table structure

-- Generate 40 rows of random data
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

-- Call the procedure to generate data
CALL GenerateDifficultyData();

