-- 1. Observe the result of running this SQL command to show the name, continent and population of all countries.
SELECT name, continent, population 
FROM world;

-- 2. Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
SELECT name FROM world
WHERE population >= 200000000;

-- 3. Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT NAME, GDP/POPULATION
FROM WORLD
WHERE POPULATION >= 200000000;

-- 4. Show the name and population in millions for the countries of the continent 'South America'. Divide the population by 1000000 to get population in millions.
SELECT NAME, POPULATION/1000000
FROM WORLD
WHERE CONTINENT = 'SOUTH AMERICA';

-- 5. Show the name and population for France, Germany, Italy
SELECT NAME, POPULATION
FROM WORLD
WHERE NAME IN ('FRANCE','GERMANY','ITALY');

-- 6. Show the countries which have a name that includes the word 'United'
SELECT NAME
FROM WORLD 
WHERE NAME LIKE '%UNITED%';

-- 7. Two ways to be big: A country is big if it has an area of more than 3 million sq km or it has a population of more than 250 million.
--Show the countries that are big by area or big by population. Show name, population and area.
SELECT NAME, POPULATION, AREA
FROM WORLD
WHERE AREA > 3000000 OR POPULATION > 250000000;

-- 8. Exclusive OR (XOR). Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both. Show name, population and area.
--Australia has a big area but a small population, it should be included.
--Indonesia has a big population but a small area, it should be included.
--China has a big population and big area, it should be excluded.
--United Kingdom has a small population and a small area, it should be excluded.
SELECT DISTINCT NAME, POPULATION, AREA FROM WORLD
WHERE (AREA > 3000000 OR POPULATION > 250000000)
AND NOT (AREA > 3000000 AND POPULATION > 250000000);

-- 9. Show the name and population in millions and the GDP in billions for the countries of the continent 'South America'. Use the ROUND function to show the values to two decimal places.
--For South America show population in millions and GDP in billions both to 2 decimal places.
SELECT name, ROUND(population/1000000,2),
             ROUND(gdp/1000000000,2)
FROM world
WHERE continent='South America';

-- 10. Show the name and per-capita GDP for those countries with a GDP of at least one trillion (1000000000000; that is 12 zeros). Round this value to the nearest 1000.
SELECT name, round (gdp/population, -3)
from world
where gdp > 1000000000000;

-- 11. Greece has capital Athens.
--Each of the strings 'Greece', and 'Athens' has 6 characters.
--Show the name and capital where the name and the capital have the same number of characters.
SELECT name, LEN(name), capital, LEN(capital)
FROM world
WHERE len(name) = len(capital);
--Why use LEN? because SQL is not compatible with LENGTH

-- 12. The capital of Sweden is Stockholm. Both words start with the letter 'S'.
--Show the name and the capital where the first letters of each match. Don't include countries where the name and the capital are the same word.
SELECT name, capital 
FROM world 
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital;

-- 13. Equatorial Guinea and Dominican Republic have all of the vowels (a e i o u) in the name. They don't count because they have more than one word in the name.
SELECT name
FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
AND name NOT LIKE '% %';

-- 1. Change the query shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- 2. Show who won the 1962 prize for Literature.
SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature';

-- 3. Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- 4. Give the name of the 'Peace' winners since the year 2000, including 2000.
SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000;

-- 5. Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
SELECT * FROM nobel
WHERE subject = 'Literature' 
AND yr BETWEEN 1980 and 1989;

-- 6. Show all details of the presidential winners:
--Theodore Roosevelt
--Woodrow Wilson
--Jimmy Carter
--Barack Obama
SELECT * FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

-- 7. Show the winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'john%';

-- 8. Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT * FROM nobel
WHERE (subject = 'Physics' AND yr = 1980) OR (subject = 'Chemistry' AND yr = 1984);

-- 9. Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
SELECT * FROM nobel
WHERE yr = 1980 AND subject <> 'Chemistry' AND subject <> 'Medicine';

-- 10. Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
SELECT * FROM nobel
WHERE (yr < 1910 AND subject = 'Medicine') OR (yr >= 2004 AND subject = 'Literature');

-- 11. Find all details of the prize won by PETER GRÜNBERG
SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG';

-- 12. Find all details of the prize won by EUGENE O'NEILL
SELECT * FROM nobel WHERE winner = 'EUGENE O''NEILL'; 

-- 13. List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner ASC;

-- 14. The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
--Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY 
CASE WHEN subject IN ('Physics','Chemistry') THEN 1 ELSE 0 END, subject,winner;

-- 1. List each country name where the population is larger than that of 'Russia'.
SELECT name FROM world
WHERE population >
(SELECT population FROM world WHERE name='Russia');

-- 2. Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name
FROM world
WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom'); 

-- 3. List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name, continent
FROM world
WHERE continent = (SELECT continent FROM world WHERE name = 'Argentina') OR continent = (SELECT continent FROM world WHERE name = 'Australia')
ORDER BY name ASC;

-- 4. Which country has a population that is more than Canada but less than Poland? Show the name and the population.
SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland');

-- 5. Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
--Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
SELECT name, CONVERT(varchar(5), CAST(ROUND(population*100/(SELECT population 
                                        FROM world 
                                        WHERE name='Germany'), 0) as INT))+'%'
FROM world 
WHERE population IN (SELECT population 
                     FROM world WHERE continent='Europe');

-- 6. Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
SELECT name FROM world 
 WHERE gdp > ALL(SELECT gdp FROM world 
 WHERE continent = 'Europe' 
   AND gdp is not null);

-- 7. Find the largest country (by area) in each continent, show the continent, the name and the area:
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT MAX (area) FROM world y
        WHERE y.continent=x.continent
          AND area>0);

-- 8. List each continent and the name of the country that comes first alphabetically.
SELECT  x.continent, x.name
FROM world x
WHERE x.name <= ALL (SELECT y.name FROM world y WHERE x.continent=y.continent)
ORDER BY name;

-- 9. Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population FROM world x
WHERE 25000000>=ALL (SELECT population FROM world y
                    WHERE x.continent=y.continent);

-- 10. Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.
SELECT x.name, x.continent
FROM world x
WHERE x.population > ALL(SELECT population*3
                        FROM world y
                        WHERE y.continent = x.continent
                        AND x.name<>y.name);
