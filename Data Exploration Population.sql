-- show all data
SELECT 
    c.country_id,
    c.country_name,
    c.land_area,
    p.world_year,
    p.global_ranking,
    p.population_count,
    p.urban_population,
    p.urban_population_percent,
    p.fertility_rate
FROM
    countries c
        JOIN
    population p ON c.country_id = p.country_id;

-- show how many countries arre there in the table
SELECT 
    COUNT(*) AS 'No. of Countries'
FROM
    countries;
    
-- show how many rows in population table 
SELECT 
    COUNT(*) AS 'No. of row'
FROM
    population;

-- select all row with null to see which country has null values
SELECT 
    *
FROM
    countries c
        JOIN
    population p ON c.country_id = p.country_id
WHERE
    p.world_year IS NULL
        OR p.global_ranking IS NULL
        OR p.population_count IS NULL
        OR p.urban_population IS NULL
        OR p.urban_population_percent IS NULL
        OR p.fertility_rate IS NULL;

-- count all rows with null values
SELECT 
    COUNT(*) 'null rows'
FROM
    countries c
        JOIN
    population p ON c.country_id = p.country_id
WHERE
    p.world_year IS NULL
        OR p.global_ranking IS NULL
        OR p.population_count IS NULL
        OR p.urban_population IS NULL
        OR p.urban_population_percent IS NULL
        OR p.fertility_rate IS NULL;

-- columns with null values only
SELECT 
    urban_population, urban_population_percent, fertility_rate
FROM
    population;

-- country  with most null values
SELECT 
    c.country_name, COUNT(p.population_id) AS Null_count
FROM
    countries AS c
        JOIN
    population AS p ON c.country_id = p.country_id
WHERE
    p.urban_population IS NULL
        OR p.urban_population_percent IS NULL
        OR p.fertility_rate IS NULL
GROUP BY c.country_name
ORDER BY Null_count DESC;

-- ##########################################################################################

SELECT 
    c.country_name,
    ROUND(AVG(p.population_count), 2) AS 'average population',
    ROUND(AVG(p.urban_population), 2) AS 'average urban population',
    ROUND(AVG(p.urban_population_percent), 2) AS 'urbanpopulation %'
FROM
    countries AS c
        JOIN
    population AS p ON c.country_id = p.country_id
GROUP BY c.country_name;

-- top 10 country with highest population count in year 2020-2023
SELECT 
    c.country_name, SUM(p.population_count) AS 'total population'
FROM
    countries AS c
        JOIN
    population AS p ON c.country_id = p.country_id
WHERE
    p.world_year >= 2020
GROUP BY country_name
ORDER BY SUM(p.population_count) DESC
LIMIT 10;

-- Average fertility rate of each country in top 10 highest population in year 2020-2023
SELECT 
    c.country_name,
    ROUND(AVG(p.fertility_rate), 2) AS 'Average Fertility Rate'
FROM
    countries AS c
        JOIN
    population AS p ON c.country_id = p.country_id
WHERE
    p.world_year >= 2020
GROUP BY country_name
ORDER BY SUM(p.population_count) DESC
LIMIT 10;

