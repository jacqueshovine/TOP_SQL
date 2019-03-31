----------------------------------------------------- 1
/* List the films where the yr is 1962 [Show id, title] */
SELECT id, title
FROM movie
WHERE yr=1962
----------------------------------------------------- 2
/* Give year of 'Citizen Kane'. */
SELECT yr
FROM movie
WHERE title='Citizen Kane'
----------------------------------------------------- 3
/* List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. */
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr
----------------------------------------------------- 4
/* What id number does the actor 'Glenn Close' have? */
SELECT id
FROM actor
WHERE name='Glenn Close'
----------------------------------------------------- 5
/* What is the id of the film 'Casablanca' */
SELECT id
FROM movie
WHERE title='Casablanca'
----------------------------------------------------- 6
/* Obtain the cast list for 'Casablanca'. Use movieid=11768 */
SELECT name
FROM casting c
JOIN movie m ON m.id = c.movieid
JOIN actor a ON a.id = c.actorid
WHERE c.movieid=11768
----------------------------------------------------- 7
/* Obtain the cast list for the film 'Alien' */
SELECT name
FROM casting c
JOIN movie m ON m.id = c.movieid
JOIN actor a ON a.id = c.actorid
WHERE m.title='Alien'
----------------------------------------------------- 8
/* List the films in which 'Harrison Ford' has appeared */
SELECT title
FROM casting c
JOIN movie m ON m.id = c.movieid
JOIN actor a ON a.id = c.actorid
WHERE a.name='Harrison Ford'
----------------------------------------------------- 9
/* List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] */
SELECT title
FROM casting c
JOIN movie m ON m.id = c.movieid
JOIN actor a ON a.id = c.actorid
WHERE a.name='Harrison Ford'
AND c.ord > 1
----------------------------------------------------- 10
/* List the films together with the leading star for all 1962 films. */
SELECT title, name
FROM casting c
JOIN movie m ON m.id = c.movieid
JOIN actor a ON a.id = c.actorid
WHERE ord = 1
AND yr=1962
----------------------------------------------------- 11
/* Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies. */
SELECT yr,COUNT(title) 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) 
FROM
	(SELECT yr,COUNT(title) AS c 
	 FROM movie 
	 JOIN casting ON movie.id=movieid
     JOIN actor ON actorid=actor.id
     WHERE name='John Travolta'
     GROUP BY yr) AS t
)
----------------------------------------------------- 12
/* List the film title and the leading actor for all of the films 'Julie Andrews' played in. */

/* -- Better solution
SELECT title, name 
FROM movie
JOIN casting x ON movie.id = movieid
JOIN actor ON actor.id =actorid
WHERE movieid IN
  (SELECT movieid FROM casting y
   JOIN actor ON actor.id=actorid
   WHERE name='Julie Andrews')
AND ord=1 */
	
	
SELECT DISTINCT title, name
FROM
  (SELECT movieid, title
   FROM casting x
   JOIN movie m ON m.id = x.movieid
   JOIN actor a ON a.id = x.actorid
   WHERE name='Julie Andrews') j -- Movies in which Julie Andrews played
JOIN casting c ON c.movieid=j.movieid
JOIN actor a ON a.id=c.actorid -- Join on actor to get actor names
WHERE ord = 1
----------------------------------------------------- 13
/* Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles */
SELECT name
FROM (SELECT name, COUNT(*) as count
  FROM casting c
  JOIN actor a ON a.id=c.actorid
  WHERE ord=1
  GROUP BY name) t
WHERE count >= 30
----------------------------------------------------- 14
/* List the films released in the year 1978 ordered by the number of actors in the cast, then by title. */
SELECT title, COUNT(c.actorid) AS actors
FROM casting c
JOIN movie m ON m.id = c.movieid
WHERE m.yr=1978
GROUP BY title
ORDER BY actors DESC, title
----------------------------------------------------- 15
/* List all the people who have worked with 'Art Garfunkel'. */
SELECT DISTINCT name
FROM casting c
JOIN actor a ON a.id = c.actorid
WHERE movieid IN
  (SELECT movieid FROM casting x
   JOIN actor ON actor.id=actorid
   WHERE name='Art Garfunkel')
AND name <> 'Art Garfunkel'