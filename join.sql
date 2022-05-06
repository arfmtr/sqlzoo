-- 1. Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player
FROM goal 
WHERE teamid = 'GER';

-- 2. From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
--Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
--Show id, stadium, team1, team2 for just game 1012
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012; 

-- 3. Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER';

-- 4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player 
FROM game
JOIN goal ON (id = matchid)
WHERE player LIKE '%Mario%';

-- 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam ON (id = teamid) 
WHERE gtime<=10; 

-- 6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
FROM game
JOIN eteam ON (team1 = eteam.id)
WHERE coach = 'Fernando Santos';

-- 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player
FROM goal
JOIN game ON (id = matchid)
WHERE stadium = 'National Stadium, Warsaw';

-- 8. The example query shows all goals scored in the Germany-Greece quarterfinal.
--Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
FROM game JOIN goal ON matchid = id
WHERE (team1 = 'GER' OR team2 = 'GER') AND teamid! = 'GER';

-- 9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(*)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname
ORDER BY teamname;

-- 10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(*)
FROM game JOIN goal ON id = matchid
GROUP BY stadium
ORDER BY stadium;

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(*)
FROM game JOIN goal ON id = matchid 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;

-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(*)
FROM game JOIN goal ON id = matchid
WHERE teamid = 'GER'
GROUP BY matchid, mdate;

-- 13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
--Sort your result by mdate, matchid, team1 and team2.
SELECT game.mdate, game.team1, 
SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) score1,
game.team2,
SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY mdate, team1, team2;

-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr=1962;

-- 2. Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4. What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'.
SELECT actor.name
FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON movie.id = casting.movieid
WHERE movie.title = 'Casablanca';

-- 7. Obtain the cast list for the film 'Alien'
SELECT actor.name
FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON movie.id = casting.movieid
WHERE movie.title = 'Alien';

-- 8. List the films in which 'Harrison Ford' has appeared
SELECT title FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE casting.ord > 1 AND actor.name = 'Harrison Ford';

-- 10. List the films together with the leading star for all 1962 films.
SELECT title, name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE casting.ord = 1 AND movie.yr = 1962;

-- 11. Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr, COUNT(title) 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1;

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name 
FROM movie  
JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE ord = 1 AND movieid IN ( SELECT movieid 
                               FROM casting JOIN actor
                               ON actorid = actor.id
                               WHERE name = 'Julie Andrews');

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT name
FROM actor JOIN casting
ON id = actorid
AND ord = 1
GROUP BY name
HAVING COUNT(name) >= 15;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(ord)
FROM movie
JOIN casting ON casting.movieid = movie.id
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(ord) DESC, title;

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT name
FROM casting
JOIN actor ON casting.actorid = actor.id
WHERE casting.movieid in (select casting.movieid
                           from casting
                           join actor on casting.actorid = actor.id
                           where name = 'Art Garfunkel')
AND name != 'Art Garfunkel'
ORDER BY name;