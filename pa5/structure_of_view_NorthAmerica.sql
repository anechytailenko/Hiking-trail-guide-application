CREATE VIEW info_abt_North_America_trail AS
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
                 WHERE ((ST_X(coordinate) BETWEEN -170 AND -160) AND (ST_Y(coordinate) BETWEEN 57 AND 70))
                    OR ((ST_X(coordinate) BETWEEN -160 AND -150) AND (ST_Y(coordinate) BETWEEN 57 AND 72))
                    OR ((ST_X(coordinate) BETWEEN -150 AND -140) AND (ST_Y(coordinate) BETWEEN 58 AND 70))
                    OR ((ST_X(coordinate) BETWEEN -140 AND -130) AND (ST_Y(coordinate) BETWEEN 50 AND 70))
                    OR ((ST_X(coordinate) BETWEEN -130 AND -120) AND (ST_Y(coordinate) BETWEEN 30 AND 79))
                    OR ((ST_X(coordinate) BETWEEN -120 AND -110) AND (ST_Y(coordinate) BETWEEN 23 AND 79))
                    OR ((ST_X(coordinate) BETWEEN -110 AND -100) AND (ST_Y(coordinate) BETWEEN 15 AND 79))
                    OR ((ST_X(coordinate) BETWEEN -100 AND -90) AND (ST_Y(coordinate) BETWEEN 10 AND 85))
                    OR ((ST_X(coordinate) BETWEEN -90 AND -80) AND (ST_Y(coordinate) BETWEEN 8 AND 86))
                    OR ((ST_X(coordinate) BETWEEN -80 AND -70) AND (ST_Y(coordinate) BETWEEN 17 AND 85))
                    OR ((ST_X(coordinate) BETWEEN -70 AND -60) AND (ST_Y(coordinate) BETWEEN 15 AND 85))
                    OR ((ST_X(coordinate) BETWEEN -60 AND -50) AND (ST_Y(coordinate) BETWEEN 45 AND 85))
                    OR ((ST_X(coordinate) BETWEEN -50 AND -40) AND (ST_Y(coordinate) BETWEEN 65 AND 87))
                    OR ((ST_X(coordinate) BETWEEN -40 AND -30) AND (ST_Y(coordinate) BETWEEN 68 AND 87))
                    OR ((ST_X(coordinate) BETWEEN -30 AND -20) AND (ST_Y(coordinate) BETWEEN 70 AND 87))
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



