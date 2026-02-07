/*
Tables:
movie(id, title, yr, director, budget, gross)
actor(id, name)
casting(movieid, actorid, ord)
*/

--#1
/*
List the films where the yr is 1962 and the budget is over 2000000
*/
SELECT id, title
FROM movie
WHERE yr=1962
AND budget > 2000000

--#2
/*
Give year of 'Citizen Kane'.
*/
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

--#3
/*
List all of the Star Trek movies, include the id, title and yr 
(all of these movies start with the words Star Trek in the title). Order results by year.
*/
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY 3

--#4
/*
What id number does the actor 'Glenn Close' have?
*/
SELECT id
FROM actor
WHERE name LIKE 'Glenn Close'

--#5
/*
What is the id of the 1942 film 'Casablanca'
*/
SELECT id
FROM movie
WHERE yr = 1942 
AND title LIKE 'Casablanca'

--#6
/*
Obtain the cast list for 1942's 'Casablanca'.
Use movieid=11768, (or whatever value you got from the previous question)
*/
SELECT name
FROM actor
JOIN casting ON actor.id = actorid
WHERE movieid = 132689

--#7
/*
Obtain the cast list for the film 'Alien'
*/
SELECT name
FROM actor
JOIN casting ON actor.id = actorid
JOIN movie ON movie.id = casting.movieid
WHERE movie.title = 'Alien'

--#8
/*
List the films in which 'Harrison Ford' has appeared
*/
SELECT title
FROM movie
JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=actorid
WHERE actor.name LIKE 'Harrison Ford'

--#9
/*
List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/
SELECT title
FROM movie
JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=actorid
WHERE actor.name LIKE 'Harrison Ford'
AND ord <> 1

--#10
/*
List the films together with the leading star for all 1962 films.
*/
SELECT title, name
FROM movie
JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=actorid
WHERE casting.ord = 1
AND movie.yr = 1962

--#11
/*
Which were the busiest years for 'Rock Hudson', show the year and the number of movies 
he made each year for any year in which he made more than 2 movies.
*/
SELECT yr, COUNT(title) AS movie_count 
FROM movie 
JOIN casting ON movie.id=movieid       
JOIN actor ON actorid=actor.id
WHERE name ='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

--#12
/*
List the film title and the leading actor for all of the films 'Julie Andrews' played in.
*/
SELECT title, name 
FROM movie
JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=actorid
WHERE movieid IN (
  SELECT movieid FROM casting
  JOIN actor ON actor.id=actorid
  WHERE name='Julie Andrews')
AND ord = 1

--#13
/*
Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
*/
SELECT name
FROM actor
JOIN casting ON actor.id=actorid AND ord=1
GROUP BY name
HAVING COUNT(1) >= 15
ORDER BY 1

--#14
/*
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/
SELECT title, COUNT(actorid) AS actors
FROM movie
JOIN casting ON movie.id=movieid 
AND yr=1978 
GROUP BY title
ORDER BY actors DESC, title

--#15
/*
List all the people who have worked with 'Art Garfunkel'.
*/
SELECT distinct name
FROM movie
JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE movie.id IN 
(SELECT movieid FROM casting 
JOIN actor ON actor.id=actorid 
WHERE name = 'Art Garfunkel')
AND actor.name <> 'Art Garfunkel'
