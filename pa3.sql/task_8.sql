-- NOT IN with correlated subqueries result
-- show trail_name which doesnt located neither in United States or in Germany 
SELECT trail.trail_name
FROM trail
WHERE location_id IN (
    SELECT id
    FROM location l1
    WHERE country NOT IN (
        SELECT country
        FROM location l2
        WHERE l1.id = l2.id
          AND country IN ('United States','Germany')
    )
);
-- updates the description of difficulty levels recommended for trails that are not located in the countries 'United States' or 'Germany'.
UPDATE difficulty
SET description = 'Recommended to visit in winter'
WHERE id IN (
    SELECT rating.difficulty_id
    FROM rating
    WHERE trail_id IN (SELECT id
    FROM trail
    WHERE location_id IN (SELECT id
        FROM location l1
        WHERE country NOT IN (SELECT country
            FROM location l2
               WHERE l1.id = l2.id
               AND country IN ('United States', 'Germany')))));
-- delete all rows from trail which doesnt located neither 'Japan','Australia'
DELETE FROM trail
WHERE location_id IN (
    SELECT id
    FROM location l1
    WHERE country NOT IN (
        SELECT country
        FROM location l2
        WHERE l1.id = l2.id
          AND country IN ('Japan','Australia')
    )
);