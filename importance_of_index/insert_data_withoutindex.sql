use withindex
-- Insert random data into the location table
INSERT INTO location (location_name, country, region, coordinate)
SELECT
    CONCAT('Location ', FLOOR(RAND() * 10000)) AS location_name,
    (CASE FLOOR(RAND() * 5)
         WHEN 0 THEN 'USA'
         WHEN 1 THEN 'Canada'
         WHEN 2 THEN 'UK'
         WHEN 3 THEN 'Australia'
         WHEN 4 THEN 'Germany'
         ELSE 'France' END) AS country,
    (CASE FLOOR(RAND() * 4)
         WHEN 0 THEN 'North'
         WHEN 1 THEN 'South'
         WHEN 2 THEN 'East'
         ELSE 'West' END) AS region,
    POINT((RAND() * 360) - 180, (RAND() * 180) - 90) AS coordinate
FROM
    information_schema.tables AS t1,
    information_schema.tables AS t2;

-- Insert random data into the trail table
-- Insert random data into the trail table with valid location_id references
INSERT INTO trail (trail_name, length, elevation, description, image, location_id)
SELECT
    CONCAT('Trail ', FLOOR(RAND() * 10000)) AS trail_name,
    ROUND(RAND() * 20 + 1, 2) AS length,
    ROUND(RAND() * 5000, 2) AS elevation,
    CONCAT('Description for ', CONCAT('Trail ', FLOOR(RAND() * 10000))) AS description,
    CONCAT('image', FLOOR(RAND() * 100) , '.jpg') AS image,
    location.id AS location_id
FROM
    (SELECT id FROM location ORDER BY RAND() LIMIT 20000) AS location
LIMIT 20000;



