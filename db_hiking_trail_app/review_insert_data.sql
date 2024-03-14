-- Assuming you have already created the `review` table structure

-- Generate 100 rows of data
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

-- Call the procedure to generate data
CALL GenerateReviewData();
