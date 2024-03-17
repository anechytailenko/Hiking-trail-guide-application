-- IN with correlated subqueries result
-- show trail_name with the greatest score 
SELECT trail.trail_name
FROM trail
WHERE trail.id IN (
    SELECT trail_id
    FROM rating
    WHERE score IN (SELECT MAX(score) FROM rating WHERE trail_id = trail.id)
);
-- update description in table difficulty where country is Japan or Germany
UPDATE difficulty
SET description = 'Recommended to visit in summer'
WHERE id IN (
    SELECT rating.difficulty_id
    FROM rating
    WHERE trail_id IN (
        SELECT id
        FROM trail
        WHERE location_id IN (
            SELECT id
            FROM location
            WHERE location_id = location.id
              AND country = 'Japan'
        )
    )
);
-- delete all rows from trail table where score is asociated with the lowest score
DELETE FROM trail
WHERE trail.id IN (
    SELECT trail_id
    FROM rating
    WHERE score IN (SELECT MIN(score) FROM rating WHERE trail_id = trail.id)
);




