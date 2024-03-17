-- NOT EXISTS with non-correlated subqueries result
-- the queryy retrieves the names of hikers who do not put score of 9.
SELECT hiker.visitor_name
FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
WHERE NOT EXISTS (SELECT score FROM rating WHERE score = 9);
-- updates the score column in the rating table, reducing each score by 10% , but only for those rows where the corresponding hiker has no associated reviews in the review table
UPDATE rating 
INNER JOIN hiker ON rating.hiker_id = hiker.id
INNER JOIN review ON hiker.id = review.hiker_id
SET score = score * 0.9
WHERE NOT EXISTS(SELECT * FROM review);

-- delete all rows from hiker where score given by hiker is not equal to the most common score(which equals 10)
DELETE FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
WHERE NOT EXISTS (SELECT score FROM rating WHERE score =(SELECT score FROM  (SELECT score, COUNT(*) AS frequency
          FROM rating
          GROUP BY score
          ORDER BY frequency DESC
          LIMIT 1) as b))
