USE withindex
SELECT trail_name 
FROM trail t
INNER JOIN (SELECT l.id FROM location l WHERE country = 'Germany') as c on c.id=t.location_id

USE withoutindex
SELECT trail_name
FROM trail t
INNER JOIN (SELECT l.id FROM location l WHERE country = 'Germany') as c on c.id=t.location_id