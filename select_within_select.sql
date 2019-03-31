---------------------------------------------------------------- 1
SELECT name FROM world
WHERE population >
  (SELECT population FROM world
  WHERE name='Russia')
---------------------------------------------------------------- 2
SELECT name 
FROM world
WHERE continent='Europe'
AND gdp/population >
    (SELECT gdp/population
     FROM world
     WHERE name='United Kingdom')
---------------------------------------------------------------- 3
SELECT name, continent
FROM world
WHERE continent IN
      (SELECT continent
       FROM world
       WHERE name IN ('Argentina', 'Australia'))
ORDER BY name
---------------------------------------------------------------- 4
SELECT name, population
FROM world
WHERE population > 
      (SELECT population
       FROM world
       WHERE name='Canada')
AND population <
    (SELECT population
     FROM world
     WHERE name='Poland')
---------------------------------------------------------------- 5
SELECT name, 
CONCAT(ROUND(population/(SELECT population FROM world WHERE name='Germany')*100), '%') AS percentage_from_Germany
FROM world
WHERE continent='Europe'
---------------------------------------------------------------- 6
SELECT name
FROM world
WHERE gdp > 
      ALL(SELECT gdp -- In MySQL the keyword ALL allow symbols like > or <= to act over a list. 
          FROM world
          WHERE gdp IS NOT NULL
          AND continent='Europe')
---------------------------------------------------------------- 7
SELECT continent, name, area
FROM world x
WHERE area > 
      ALL(SELECT area
          FROM world y
          WHERE x.continent = y.continent
          AND x.name <> y.name)
---------------------------------------------------------------- 8
SELECT continent, name
FROM world x
WHERE name = (SELECT name
       FROM world y
       WHERE x.continent = y.continent
       ORDER BY name
       LIMIT 1)
---------------------------------------------------------------- 9
SELECT name, continent, population 
FROM world
WHERE continent NOT IN 
      (SELECT DISTINCT continent FROM world WHERE population >= 25000000);
---------------------------------------------------------------- 10
SELECT name, continent
FROM world x
WHERE population/3 >=
      ALL(SELECT population
      FROM world y
      WHERE x.continent = y.continent
      AND x.name <> y.name)