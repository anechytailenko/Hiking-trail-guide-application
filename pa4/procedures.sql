
-- SELECT moderate hiker who give a certain score to a certain trail
DELIMITER //
CREATE PROCEDURE get_moderate_hiker_by_trail_and_rating(IN name_of_trail VARCHAR(255), IN score_rating VARCHAR(255))
BEGIN 
    SELECT visitor_name 
    FROM hiker
    WHERE p_type = 'moderate' AND hiker.id IN (SELECT hiker_id FROM rating INNER JOIN trail ON trail.id = rating.trail_id WHERE score = score_rating AND trail_name = name_of_trail );      
END //
DELIMITER ;

 -- show amount of hikers who wrote at least two review
DELIMITER //
CREATE PROCEDURE get_amount_of_people_who_wrote_at_least_two_review(OUT amount_of_hiker INT)
BEGIN 
    SELECT COUNT(hiker.id) 
    INTO amount_of_hiker
    FROM hiker
    WHERE id in (SELECT hiker_id FROM ( SELECT review.hiker_id, COUNT(review.title) FROM review GROUP BY hiker_id HAVING COUNT(title)>1) AS subquery);
END //
DELIMITER ;

 -- show number of trails with a given score that was given by moderate hikers
DELIMITER //
CREATE PROCEDURE get_amount_of_trails_with_given_score_from_moderate_users(INOUT amount_of_trail INT )
BEGIN 
    SELECT COUNT(rating.trail_id)
    INTO amount_of_trail
    FROM rating 
    WHERE score = amount_of_trail AND hiker_id IN (SELECT id FROM hiker WHERE p_type = 'moderate');
END //
DELIMITER ;

-- user give the number by which the score (which is associated with given country) will be decreased. Transaction is not implemented if the score after decreasing is less than 0
DELIMITER //
CREATE PROCEDURE reduce_score_by_location(IN reduction_of_score DOUBLE (10,2), IN name_country VARCHAR(255))
BEGIN
    DECLARE rollback_message VARCHAR(255) DEFAULT 'Transaction rolled back: because after change score less than 0';
    DECLARE commit_message VARCHAR(255) DEFAULT 'Transaction committed successfully';
    START TRANSACTION;
    
    UPDATE rating
    SET score = score - reduction_of_score
    WHERE trail_id IN ( SELECT trail.id FROM trail INNER JOIN location ON location_id = location.id WHERE country = name_country );
    
    SELECT COUNT(rating.score)
    INTO @difference
    FROM rating
    WHERE score < 0 ;
    
    IF @difference > 0 THEN
        ROLLBACK ;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = rollback_message;
    ELSE
        COMMIT;
        SELECT commit_message AS 'Result';
    END IF;
END //
DELIMITER ;







