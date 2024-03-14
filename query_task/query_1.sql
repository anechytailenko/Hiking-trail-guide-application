SELECT d.level AS Level, COUNT(t.id) AS Amount_of_trails
FROM trail t
         JOIN rating r ON t.id = r.trail_id
         JOIN difficulty d ON r.difficulty_id = d.id
GROUP BY d.level
ORDER BY COUNT(t.id);
-- display amount of trails that according to three difficulty levels ( easy,moderate,hard)



