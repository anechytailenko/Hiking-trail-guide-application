-- EXISTS with non-correlated subqueries result
-- show name of the hiker if it has given to some trail score 1 and the review was written 
SELECT DISTINCT hiker.visitor_name
FROM hiker
INNER JOIN rating on hiker.id = rating.hiker_id
INNER JOIN review on hiker.id = review.hiker_id
WHERE score = 1 AND EXISTS (SELECT review.hiker_id FROM review);
-- Update this query increases the scores of ratings associated with "moderate" hikers by 20%, but only if their score was originally less than 10.
UPDATE rating
INNER JOIN hiker ON rating.hiker_id = hiker.id
SET score = score *1.2
WHERE score < 10 AND EXISTS (SELECT 1 FROM hiker WHERE p_type = 'moderate');
-- delete  all rows from ratings where score = 5 and hiker tstatus is moderate
DELETE rating
    INNER JOIN hiker ON rating.hiker_id = hiker.id
WHERE score = 5 AND EXISTS (SELECT 1 FROM hiker WHERE p_type = 'moderate');