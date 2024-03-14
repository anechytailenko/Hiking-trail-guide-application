-- Assuming you have already created the `rating` table structure

-- Generate 100 rows of data
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

-- Call the procedure to generate data
CALL GenerateRatingsDatasss();

