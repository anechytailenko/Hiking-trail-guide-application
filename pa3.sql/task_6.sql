-- = with correlated subqueries result
-- show trail name if it is located in some country in West Coast region
SELECT trail.trail_name
FROM trail
WHERE location_id = ANY (
    SELECT id
    FROM location
    WHERE country = ANY (
        SELECT country
        FROM location l
        WHERE l.id = trail.location_id
          AND l.region = 'West Coast'
    ))
;
-- updates the scores for all ratings associated with a 'hard' level and reduces the scores by 5% .
UPDATE rating
SET score = score * 0.95
WHERE difficulty_id = ANY (
    SELECT id
    FROM difficulty
    WHERE level = (
        SELECT level
        FROM difficulty
        WHERE difficulty_id = difficulty.id
          AND level = 'hard'
    )
);
-- delete all rows from rating where difficulty level is considered to be easy
DELETE FROM rating
WHERE difficulty_id = ANY (
    SELECT id
    FROM difficulty d
    WHERE level = (
        SELECT level
        FROM difficulty
        WHERE id = rating.difficulty_id
    )
      AND level = 'easy'
);

