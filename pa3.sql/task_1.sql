-- = with non-correlated subqueries result
--  show trails that located in Canada or Japan
USE hiking_trail_guide_app
SELECT trail_name
FROM trail
WHERE location_id = ANY
      (SELECT id
       FROM location
       WHERE country = 'Canada'or country = 'Japan');
-- set new score to the trail that equals 10 if the level is hard
UPDATE rating
SET score = 10
WHERE difficulty_id = ANY (
    SELECT id
    FROM difficulty
    WHERE level = 'hard'
)
-- Delete all rows from table location which contain country that is the most popular in hiking_app
DELETE FROM location
WHERE country = (
    SELECT country
    FROM (
             SELECT country, COUNT(id) as amount
             FROM location
             GROUP BY country
             ORDER BY amount DESC
             LIMIT 1
         ) AS subquery
);
