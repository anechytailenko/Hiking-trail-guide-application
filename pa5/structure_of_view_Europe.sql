CREATE VIEW info_abt_Europe_trail AS
SELECT gist_content.trail_name,gist_content.image ,gist_content.coordinates, gist_content.description, (SUBSTRING_INDEX(SUBSTRING_INDEX(gist_content.first_sentences, ';', 2), ';', -2)) AS first_two_sentences_review_content
FROM (
         SELECT COUNT(review.id) AS trail_count, review.trail_id
         FROM review
                  INNER JOIN trail ON review.trail_id = trail.id
         WHERE trail_id IN (
             SELECT id FROM trail
             WHERE location_id IN (
                 SELECT id
                 FROM location
                 WHERE ((ST_X(coordinate) BETWEEN -25 AND -15) AND (ST_Y(coordinate) BETWEEN 62 AND 67))
                    OR ((ST_X(coordinate) BETWEEN -10 AND 0) AND (ST_Y(coordinate) BETWEEN 35 AND 70))
                    OR ((ST_X(coordinate) BETWEEN 0 AND 10) AND (ST_Y(coordinate) BETWEEN 37 AND 65))
                    OR ((ST_X(coordinate) BETWEEN 20 AND 30) AND (ST_Y(coordinate) BETWEEN 33 AND 73))
                    OR ((ST_X(coordinate) BETWEEN 30 AND 40) AND (ST_Y(coordinate) BETWEEN 45 AND 53))
             )
         )
         GROUP BY trail_id
         ORDER BY COUNT(review.id) DESC
     ) AS value_popularity
         INNER JOIN (
    SELECT trail.description,trail.image,ST_AsText(location.coordinate) AS coordinates, trail.trail_name,review.trail_id, GROUP_CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(review.content, '.', 1), '.', -1) ORDER BY review_date DESC SEPARATOR ';' )AS first_sentences
    FROM review
             INNER JOIN trail ON review.trail_id = trail.id
             INNER JOIN location ON location.id= trail.location_id
    GROUP BY trail_id
) AS gist_content ON value_popularity.trail_id = gist_content.trail_id;



