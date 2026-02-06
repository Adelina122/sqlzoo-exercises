/*
Tables:
ttms(games, color, who, country)
ttmd(games, color, team, country)
country(id, name)
games(yr, city, country)
team(id, name)
*/

--#1
/*
Show the athelete (who) and the country name for medal winners in 2000.
*/
SELECT who, country.name
FROM ttms 
JOIN country ON (ttms.country=country.id)
WHERE games = 2000

--#2
/*
Show the who and the color of the medal for the medal winners from 'Sweden'.
*/
SELECT who, color
FROM ttms
JOIN country ON country.id=ttms.country
WHERE country.name = 'SWEDEN'

--#3
/*
Show the years in which 'China' won a 'gold' medal.
*/
SELECT games
FROM ttms
JOIN country ON ttms.country=country.id
WHERE country.name = 'China' 
AND color = 'gold'

--#4
/*
Show who won medals in the 'Barcelona' games.
*/
SELECT who
  FROM ttws JOIN games
            ON (ttws.games=games.yr)
  WHERE city = 'Barcelona'

--#5
/*
Show which city 'Jing Chen' won medals. Show the city and the medal color.
*/
SELECT city, color
FROM ttws
JOIN games ON ttws.games=games.yr
WHERE who = 'Jing Chen'

--#6
/*
Show who won the gold medal and the city.
*/
SELECT who, city
FROM ttws
JOIN games ON ttws.games=games.yr
WHERE color = 'gold'

--#7
/*
Show the games and color of the medal won by the team that includes 'Yan Sen'.
*/
SELECT games, color
FROM ttmd
JOIN team ON ttmd.team=team.id
WHERE team.name = 'Yan Sen'

--#8
/*
Show the 'gold' medal winners in 2004.
*/
SELECT team.name
FROM ttmd
JOIN team ON ttmd.team=team.id
WHERE color = 'gold' 
AND ttmd.games = 2004

--#9
/*
Show the name of each medal winner country 'FRA'.
*/
SELECT team.name
FROM team
JOIN ttmd ON ttmd.team=team.id
WHERE ttmd.country = 'FRA’





























