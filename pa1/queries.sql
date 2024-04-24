-- Query one
SELECT d.level AS Level, COUNT(t.id) AS Amount_of_trails
FROM trail t
         JOIN rating r ON t.id = r.trail_id
         JOIN difficulty d ON r.difficulty_id = d.id
GROUP BY d.level
ORDER BY COUNT(t.id);
-- display amount of trails that according to three difficulty levels ( easy,moderate,hard)
-- Query two
SELECT COUNT(t.id) AS Amount_of_trails
FROM rating r
         INNER JOIN (SELECT hiker.id FROM hiker WHERE hiker.p_type='pro') as h on h.id= r.hiker_id
         INNER JOIN (SELECT difficulty.id FROM difficulty WHERE difficulty.level='easy') as d on d.id=r.difficulty_id
         INNER JOIN trail t on t.id= r.trail_id;
-- display amount of trails with easy level of difficulty from pro users





