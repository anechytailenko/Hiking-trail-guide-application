-- EXISTS with correlated subqueries result
-- show all hukers who gave score 8
SELECT h.visitor_name
FROM hiker h
WHERE EXISTS (
    SELECT 1
    FROM rating r
    WHERE r.hiker_id = h.id
      AND r.score = 8
);
-- Update this query increases the scores of ratings associated with "pro" hikers by 10%, but only if their score was originally less than 10.
UPDATE rating
SET score = score * 1.1
WHERE score < 10 AND EXISTS (
    SELECT 1
    FROM hiker
    WHERE rating.hiker_id = hiker.id
      AND hiker.p_type = 'pro'
);
-- delete all rows from hiker where score is associated with 7
DELETE FROM hiker h
WHERE EXISTS (
    SELECT 1
    FROM rating r
    WHERE r.hiker_id = h.id
      AND r.score = 7
);