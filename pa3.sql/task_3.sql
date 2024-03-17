-- NOT IN with non-correlated subqueries result
-- show all hikers that havent written any review and has a status of pro 
SELECT hiker.visitor_name
FROM hiker
WHERE id NOT IN (SELECT review.hiker_id FROM review ) AND p_type = 'pro';
-- update status of hiker if he/she hasnt written any review
UPDATE hiker
SET p_type = 'noob'
WHERE id NOT IN (SELECT review.hiker_id FROM review );
-- delete all rows from table  hiker that havent written any review and has a status of noob
DELETE FROM hiker
WHERE id NOT IN (SELECT review.hiker_id FROM review ) AND p_type = 'noob';
