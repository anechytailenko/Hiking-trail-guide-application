-- IN with non-correlated subqueries result
-- show titles of reviews which were written by users with status of moderate or noob and their score for given trail equal to 1
SELECT title FROM review
WHERE hiker_id IN (SELECT id FROM hiker WHERE p_type='moderate' OR p_type='noob')
AND hiker_id IN (SELECT hiker_id FROM rating WHERE score=1);
-- update description with a caustion about spiders if country is Canada
UPDATE difficulty
SET description = 'Now there is a season of spider infestation'
WHERE id IN (
    SELECT rating.difficulty_id
    FROM rating
             INNER JOIN trail ON rating.trail_id = trail.id
             INNER JOIN location ON trail.location_id = location.id
    WHERE location.country = 'Canada'
);
-- delete all rows in difficulty where country is associated with Canada and Germany
DELETE FROM difficulty
WHERE id IN (
    SELECT d.id
    FROM difficulty d
             INNER JOIN trail t ON d.id = t.difficulty_id
             INNER JOIN location l ON t.location_id = l.id
    WHERE l.country IN ('Canada', 'Germany')
);

