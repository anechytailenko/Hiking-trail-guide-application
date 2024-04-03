-- PROCEDURE get_moderate_hiker_by_trail_and_rating SELECT moderate hiker who give a certain score to a certain trail
CALL get_moderate_hiker_by_trail_and_rating('Trail_58_in_Location_18',5);
-- show the name of the hiker with moderate type who give score 5 to trail 'Trail_58_in_Location_18'

-- PROCEDURE get_amount_of_people_who_wrote_at_least_two_review show amount of hikers who wrote at least two review
CALL get_amount_of_people_who_wrote_at_least_two_review(@amount_of_hiker);
SELECT @amount_of_hiker;
-- show amount of hikers who wrote at least two review

-- PROCEDURE get_amount_of_trails_with_given_score_from_moderate_users
SET @amount_of_trail= 5;
CALL get_amount_of_trails_with_given_score_from_moderate_users(@amount_of_trail);
SELECT @amount_of_trail;
-- show amount of trails with the score 5 that was given only by moderate user

-- PROCEDURE reduce_score_by_location reduce values in score column by given decimal if the score associated with a given country. Transaction is implemented if the score after change greater than 0
CALL reduce_score_by_location(0.5,'Australia');
CALL reduce_score_by_location(0.75,'Australia');
-- As we can see the first transaction was successful cause the scores after change remain greater than 0 or equal 0 
-- otherwise the second transaction failed because the score constitute negative value