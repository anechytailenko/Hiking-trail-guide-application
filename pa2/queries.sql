-- Query one
SELECT trail_name
FROM trail t
INNER JOIN (SELECT l.id FROM location l WHERE country IN ('Japan','United States') as c on c.id=t.location_id
-- Query two
SELECT trail_name
FROM trail t
INNER JOIN (SELECT l.id FROM location l WHERE country = 'Germany') as c on c.id=t.location_id


