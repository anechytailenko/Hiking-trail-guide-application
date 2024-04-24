-- Assuming you have already created the `location` table structure

-- Generate 40 rows of plausible data with a greater range of countries
DELIMITER //
CREATE PROCEDURE GenerateExpandedLocationData()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE loc_name VARCHAR(255);
    DECLARE cntry VARCHAR(255);
    DECLARE regn VARCHAR(255);
    DECLARE lat DECIMAL(9,6);
    DECLARE lon DECIMAL(9,6);
    
    WHILE i < 40 DO
        SET loc_name = CONCAT('Location_', i+1);
        SET cntry = CASE FLOOR(RAND() * 6)
            WHEN 0 THEN 'United States'
            WHEN 1 THEN 'Canada'
            WHEN 2 THEN 'Australia'
            WHEN 3 THEN 'United Kingdom'
            WHEN 4 THEN 'Germany'
            ELSE 'Japan'
END;
        SET regn = CASE cntry
            WHEN 'United States' THEN 
                CASE FLOOR(RAND() * 3)
                    WHEN 0 THEN 'West Coast'
                    WHEN 1 THEN 'East Coast'
                    ELSE 'Midwest'
END
WHEN 'Canada' THEN 
                CASE FLOOR(RAND() * 3)
                    WHEN 0 THEN 'Ontario'
                    WHEN 1 THEN 'British Columbia'
                    ELSE 'Alberta'
END
WHEN 'Australia' THEN 
                CASE FLOOR(RAND() * 3)
                    WHEN 0 THEN 'New South Wales'
                    WHEN 1 THEN 'Victoria'
                    ELSE 'Queensland'
END
WHEN 'United Kingdom' THEN 
                CASE FLOOR(RAND() * 3)
                    WHEN 0 THEN 'England'
                    WHEN 1 THEN 'Scotland'
                    ELSE 'Wales'
END
WHEN 'Germany' THEN 
                CASE FLOOR(RAND() * 3)
                    WHEN 0 THEN 'Bavaria'
                    WHEN 1 THEN 'North Rhine-Westphalia'
                    ELSE 'Baden-Württemberg'
END
ELSE 
                CASE FLOOR(RAND() * 3)
                    WHEN 0 THEN 'Kanto'
                    WHEN 1 THEN 'Kansai'
                    ELSE 'Chubu'
END
END;
        SET lat = RAND() * 180 - 90; -- Latitude range: -90 to 90
        SET lon = RAND() * 360 - 180; -- Longitude range: -180 to 180

INSERT INTO location (location_name, country, region, coordinate)
VALUES (loc_name, cntry, regn, POINT(lat, lon));

SET i = i + 1;
END WHILE;
END//
DELIMITER ;

-- Call the procedure to generate data with expanded countries
CALL GenerateExpandedLocationData();
