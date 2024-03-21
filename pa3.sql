-- = with non-correlated subqueries result
-- No1 show trails that located in Canada or Japan
USE hiking_trail_guide_app;
SELECT trail_name
FROM trail
WHERE location_id = ANY
      (SELECT id
       FROM location
       WHERE country = 'Canada'or country = 'Japan');
-- No2 set score 10 in table rating if the difficulty was hard and was given by pro hiker
UPDATE rating
SET score = 10
WHERE difficulty_id = ANY (
    SELECT id
    FROM difficulty
    WHERE level = 'hard'
)
  AND
    hiker_id = ANY(SELECT id FROM hiker WHERE p_type='pro')
;
-- No 3 Delete information about hiker if he/she hasnt anything type since 2024
DELETE FROM hiker
WHERE id = ANY(SELECT hiker_id FROM review WHERE review_date<'2024-01-01');
-- IN with non-correlated subqueries result
-- No 4 show titles of reviews which were written by users with status of moderate or noob and their score for given trail equal to 1
SELECT title FROM review
WHERE hiker_id IN
      (SELECT id FROM hiker WHERE p_type='moderate' OR p_type='noob')
  AND hiker_id IN
      (SELECT hiker_id FROM rating WHERE score=1);
-- No 5 update description with a caustion about spiders if country is Canada
UPDATE trail
SET trail.description = 'Now there is a season of spider infestation'
WHERE trail.id IN (
    SELECT id
    FROM location
    WHERE location.country = 'Canada'
);
-- No 6 delete rows in table location if the trails elevation ia greater than 3600
DELETE
FROM location
WHERE id IN (SELECT trail.location_id FROM trail WHERE elevation <3600);
-- NOT IN with non-correlated subqueries result
-- No 7 show all hikers that havent written any review and has a status of pro 
SELECT hiker.visitor_name
FROM hiker
WHERE id NOT IN (SELECT review.hiker_id FROM review ) AND p_type = 'pro';
-- No 8 update status of hiker if he/she hasnt written any review
UPDATE hiker
SET p_type = 'noob'
WHERE id NOT IN (SELECT review.hiker_id FROM review );
-- No 9 delete rows in table trail if the there wasnt any review about such trail
DELETE
FROM trail
WHERE id NOT IN (SELECT trail_id FROM review)
-- EXISTS with non-correlated subqueries result
-- No 10 show the average score for each trail if there exists score 1
SELECT distinct trail_name,AVG(score) as amount
FROM trail
         INNER JOIN rating ON trail.id = rating.trail_id
GROUP BY trail_name
HAVING EXISTS(SELECT score FROM rating where score = 1)
ORDER BY amount;
-- No 11 update info in difficulty table if the level is easy and exists any info in table trail
UPDATE difficulty d
SET description = 'Suitable for family trip'
WHERE EXISTS(SELECT 1 FROM trail) AND d.level='easy';
-- No 12 delete info from trails if it is associated  with score greater than 10
DELETE
FROM trail
WHERE EXISTS (SELECT 1 FROM rating WHERE score > 10);
-- NOT EXISTS with non-correlated subqueries result
-- No 13 show how many trails is located in each country if in table difficulty not exist any 'normal' level
SELECT country,COUNT(trail_name) as amount_of_trails
FROM location
         INNER jOIN trail ON location.id = trail.location_id
GROUP BY country
HAVING NOT EXISTS (SELECT 1 FROM difficulty WHERE level='normal');
-- No 14 reduce score by 10% if there isnt any records about location in Spain and hiker status is noob
UPDATE rating
    INNER JOIN hiker ON rating.hiker_id = hiker.id
SET score = score * 0.9
WHERE NOT EXISTS(SELECT 1 FROM location WHERE country='Spain') AND  hiker.p_type='noob';
-- No 15 DELETE all rows in table trail that is one of the least reviewed trail if there isnt any record in rating with 0 score
DELETE FROM trail
WHERE NOT EXISTS(SELECT 1 FROM rating WHERE score = 0)
  AND
    trail.id = (SELECT id FROM (SELECT COUNT(title) as occurance,trail.id
                                FROM review
                                         INNER JOIN trail ON review.trail_id = trail.id
                                GROUP BY trail.id
                                ORDER BY occurance
                                LIMIT 1) as occur);
-- = with correlated subqueries result
-- No 16 show the date of the most recent review made by each hiker
SELECT review_date ,visitor_name
FROM
    review r1
        JOIN
    hiker h1 ON r1.hiker_id = h1.id
WHERE
    r1.review_date = (
        SELECT MAX(r2.review_date)
        FROM review r2
        WHERE r2.hiker_id = h1.id
    );
-- No 17 reduce the score in the rating table by 5% for all entries where the difficulty_id corresponds to a difficulty level 'hard'
UPDATE rating r1
SET score = score * 0.95
WHERE difficulty_id = (
    SELECT id
    FROM difficulty d2
    WHERE level = 'hard'
      AND r1.difficulty_id=d2.id);

-- No 18 delete rows from the review table (r1) where the hiker_id matches the id of hikers who are noob
DELETE FROM review r1
WHERE hiker_id = (SELECT h2.id
                  FROM hiker h2
                  WHERE r1.hiker_id=h2.id AND p_type='noob');

-- No 19 show max elevation,trail and its country in each location
SELECT t.trail_name, t.elevation, l.country
FROM trail t
         JOIN location l ON t.location_id = l.id
WHERE t.elevation IN (
    SELECT MAX(t2.elevation)
    FROM trail t2
    WHERE t2.location_id = l.id
);
-- No 20 update description 'Suitable only for pro' in trail if elevation >3600 and level hard
UPDATE trail
SET description= 'Suitable only for pro'
WHERE id IN (SELECT trail_id
             FROM rating r2
                      INNER JOIN difficulty ON r2.difficulty_id = difficulty.id
             WHERE trail.id = r2.trail_id AND elevation>3600 AND level='hard' );
-- No 21 delete all rows in rating if this trail is started with letter A%
DELETE
FROM rating
WHERE rating.trail_id IN (SELECT t2.id FROM trail t2
                                                INNER JOIN location ON t2.location_id = location.id
                          WHERE country IN (SELECT country FROM location  WHERE t2.location_id=location.id  AND country LIKE 'A%')) ;
-- NOT IN with correlated subqueries result
-- 22 display info about trail with its country location where elevation is not the same as the minimum elevation of trails in the same location
SELECT t.trail_name, t.elevation, l.country
FROM trail t
         JOIN location l ON t.location_id = l.id
WHERE t.elevation NOT IN (
    SELECT MIN(t2.elevation)
    FROM trail t2
    WHERE t2.location_id = l.id);
-- 23  updates the description of trails to 'Recommended to visit in winter' for trails located in countries other than Japan, Australia, United States, or United Kingdom
UPDATE trail
SET trail.description = 'Recommended to visit in winter'
WHERE trail.location_id NOT IN ( SELECT id
                                 FROM location l2
                                 WHERE l2.id=trail.location_id AND country IN ('Japan','Australia','United States','United Kingdom'));
-- 24 deletes ratings associated with trails whose corresponding location's country does not start with 'U
DELETE FROM rating
WHERE rating.trail_id NOT IN (
    SELECT t2.id
    FROM trail t2
             INNER JOIN location ON t2.location_id = location.id
    WHERE country IN (
        SELECT country
        FROM location
        WHERE t2.location_id = location.id AND country LIKE 'U%'
    )
);
-- EXISTS with correlated subqueries result
-- No 25 show all hikers with pro if there is at least one record later than 2024 associated with this hiker
SELECT h.visitor_name
FROM hiker h
WHERE EXISTS (
    SELECT 1
    FROM review r
    WHERE r.hiker_id = h.id AND review_date>'2024-01-01')
  AND p_type = 'pro';
-- 26 updates scores in the 'rating' table, multiplying them 20%, for rows where the score is less than 8 and where the hiker is pro
UPDATE rating
SET score = score * 1.2
WHERE score < 8 AND EXISTS (
    SELECT 1
    FROM hiker
    WHERE rating.hiker_id = hiker.id
      AND hiker.p_type = 'pro'
);
-- 27 deletes hikers from the 'hiker' table if they have at least one rating with a score of 7 and their 'p_type' is "noob"
DELETE FROM hiker h
WHERE EXISTS (
    SELECT 1
    FROM rating r
    WHERE r.hiker_id = h.id
      AND r.score = 7)
  AND p_type = 'noob';
-- NOT EXISTS with correlated subqueries resul
-- No 28 display all moderate hikers who havent given 10 
SELECT h.visitor_name
FROM hiker h
WHERE NOT EXISTS (
    SELECT 1
    FROM rating r
    WHERE r.hiker_id = h.id AND r.score = 10)
  AND p_type ='moderate';
-- 29 increase by 10 % if the score less than 10 and the score wasnt given by moderate or noob user
UPDATE rating
SET score = score * 1.1
WHERE score < 10 AND NOT EXISTS (
    SELECT 1
    FROM hiker
    WHERE rating.hiker_id = hiker.id
      AND hiker.p_type IN ('noob','moderate'));
-- 30deletes trails from the 'trail' table if there are no ratings with a score greater than 9 associated with that trail and if the elevation of the trail is greater than 3600
DELETE FROM trail t
WHERE NOT EXISTS (
    SELECT 1
    FROM rating r
             JOIN difficulty d ON r.difficulty_id = d.id
    WHERE r.trail_id = t.id AND score >9)
  AND t.elevation >3600;

-- UNION
-- No 31 show hikers who visited at least United Kingdom or Canada
SELECT hiker.visitor_name
FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
         INNER JOIN trail ON rating.trail_id = trail.id
         INNER JOIN location ON trail.location_id = location.id
WHERE country = 'United Kingdom'
UNION
SELECT hiker.visitor_name
FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
         INNER JOIN trail ON rating.trail_id = trail.id
         INNER JOIN location ON trail.location_id = location.id
WHERE country = 'Canada';
-- UNION ALL
-- No 32 show hikers who give score 7 and 4(if there will be repetition it means that hiker gave scores 7 and 4 
SELECT hiker.visitor_name
FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
WHERE score = 7
UNION ALL
SELECT hiker.visitor_name
FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
WHERE score = 4;
-- INTERSECT
-- No 33 show hikers who visited Japan and Germany 
SELECT hiker.visitor_name
FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
         INNER JOIN trail ON rating.trail_id = trail.id
         INNER JOIN location ON trail.location_id = location.id
WHERE country = 'Japan'
INTERSECT
SELECT hiker.visitor_name
FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
         INNER JOIN trail ON rating.trail_id = trail.id
         INNER JOIN location ON trail.location_id = location.id
WHERE country = 'Germany';
-- EXCEPT
-- No 34 show hikers who visited United States but have never visited Australia
SELECT hiker.visitor_name
FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
         INNER JOIN trail ON rating.trail_id = trail.id
         INNER JOIN location ON trail.location_id = location.id
WHERE country = 'United States'
EXCEPT
SELECT hiker.visitor_name
FROM hiker
         INNER JOIN rating ON hiker.id = rating.hiker_id
         INNER JOIN trail ON rating.trail_id = trail.id
         INNER JOIN location ON trail.location_id = location.id
WHERE country = 'Australia';
;



























