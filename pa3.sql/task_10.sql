-- NOT EXISTS with correlated subqueries resul
-- show trail_name with easy or moderate difficulty
SELECT trail_name
FROM trail t
WHERE NOT EXISTS (
    SELECT 1
    FROM rating r
             JOIN difficulty d ON r.difficulty_id = d.id
    WHERE r.trail_id = t.id
      AND d.level = 'hard'
);
-- update description for trails that not located in'Australia','United States','Japan','Germany','Canada'
UPDATE difficulty
    INNER JOIN rating ON difficulty.id = rating.difficulty_id
    INNER JOIN trail ON rating.trail_id = trail.id
SET difficulty.description = 'The weather is bad'
WHERE NOT EXISTS(SELECT * FROM location WHERE trail.location_id=location.id AND country IN ('Australia','United States','Japan','Germany','Canada'));
-- delete all rows from trail table that is associated with moderate difficulty level 
DELETE FROM trail t
WHERE NOT EXISTS (
    SELECT 1
    FROM rating r
             JOIN difficulty d ON r.difficulty_id = d.id
    WHERE r.trail_id = t.id
      AND d.level = 'moderate'
);