-- rename population field in the population table
alter table population
change population population_count bigint;


-- decided to to remove a row that has 3 or more null values and impute if lower than 3
	-- create a temporary table with the rows to be deleted
CREATE TEMPORARY TABLE temp_table AS
SELECT country_id
FROM population
WHERE population_count IS NULL
    OR urban_population IS NULL
    OR urban_population_percent IS NULL
    OR fertility_rate IS NULL
GROUP BY country_id
HAVING COUNT(country_id) > 2;

-- delete the rows from the original table using the temporary table
DELETE FROM population
WHERE country_id IN (SELECT * FROM temp_table);

-- Drop the temporary table
DROP TEMPORARY TABLE IF EXISTS temp_table;

-- impute the row that has lower than 
	-- for oman(urban population) id = 127
UPDATE population 
SET 
    urban_population = ROUND(COALESCE(urban_population,
                    (SELECT 
                            AVG(p.urban_population)
                        FROM
                            (SELECT 
                                *
                            FROM
                                population
                            WHERE
                                country_id = 127) AS p)),
            2)
WHERE
    urban_population IS NULL
        AND country_id = 127;
    
    -- for oman(urban population percentage)
UPDATE population 
SET 
    urban_population_percent = ROUND(COALESCE(urban_population_percent,
                    (SELECT 
                            AVG(p.urban_population_percent)
                        FROM
                            (SELECT 
                                *
                            FROM
                                population
                            WHERE
                                country_id = 127) AS p)),
            2)
WHERE
    urban_population_percent IS NULL
        AND country_id = 127;
        
        
	-- for Western Sahara (urban_population) id = 172
UPDATE population 
SET 
    urban_population = ROUND(COALESCE(urban_population,
                    (SELECT 
                            AVG(p.urban_population)
                        FROM
                            (SELECT 
                                *
                            FROM
                                population
                            WHERE
                                country_id = 172) AS p)),
            2)
WHERE
    urban_population IS NULL
        AND country_id = 172;
        
    -- for Western Sahara (urban_population_percent) id = 172
UPDATE population 
SET 
    urban_population_percent = ROUND(COALESCE(urban_population_percent,
                    (SELECT 
                            AVG(p.urban_population_percent)
                        FROM
                            (SELECT 
                                *
                            FROM
                                population
                            WHERE
                                country_id = 172) AS p)),
            2)
WHERE
    urban_population_percent IS NULL
        AND country_id = 172;
        

