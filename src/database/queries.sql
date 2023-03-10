/* Select all players (id, name, first_name and bib_number) */
select id, last_name, first_name, bib_number from players;

/* Select only the players with a name starting by ‘A’ */
select id, last_name, first_name, bib_number from players
WHERE last_name like 'A%';

select id, last_name, first_name, bib_number from players
WHERE left(last_name,1) ='A';

/* Select only the players with a ‘a’ inside their name */
select id, last_name, first_name, bib_number from players
WHERE last_name like '%a%';

/* Select the players with their team’s name and color*/
SELECT * from players
inner join teams on players.team_id = teams.id;

/* Select all the team’s countries but the must appear only once.*/
select distinct(country) from teams;

/* Select the matches planned in the future*/
select * from matchs where start_time > now();

/* Select the finished matches*/
select * from matchs 
where end_time is not null 
and winner_team_id is not null;

/* Select all the players involved in a match via their team. */
select * from players
inner join teams on teams.id = players.team_id
inner join team_matchs on teams.id = team_matchs.team_id
inner join matchs on matchs.id = team_matchs.match_id
WHERE matchs.id = 1;

/* Find the highest score of the tournament and select the corresponding game it was for. */

SELECT g.title, tm.score FROM team_matchs tm
INNER JOIN matchs m ON tm.match_id = m.id
INNER JOIN games g ON m.game_id = g.id
WHERE tm.score = ( SELECT MAX(score) FROM team_matchs );

SELECT g.title, tm.score 
FROM team_matchs tm
INNER JOIN matchs m ON tm.match_id = m.id
INNER JOIN games g ON m.game_id = g.id
ORDER BY tm.score desc
LIMIT 1;

/* Create a query that display the match schedule for a team. Add the game, the room and the referee information */
SELECT t.name, m.start_time, g.title, ro.name, 
CONCAT(re.last_name," ", re.first_name) AS "referee"
FROM matchs m
INNER JOIN games g ON m.game_id = g.id
INNER JOIN referees re ON re.id = m.referee_id
INNER JOIN rooms ro ON ro.id = m.room_id
INNER JOIN team_matchs tm ON tm.match_id = m.id
INNER JOIN teams t ON t.id = tm.team_id;

/* Create a query that display the match schedule for a player.*/
SELECT p.bib_number, p.last_name, t.name, m.start_time, g.title, ro.name, 
CONCAT(re.last_name," ", re.first_name) AS "referee"
FROM matchs m
INNER JOIN games g ON m.game_id = g.id
INNER JOIN referees re ON re.id = m.referee_id
INNER JOIN rooms ro ON ro.id = m.room_id
INNER JOIN team_matchs tm ON tm.match_id = m.id
INNER JOIN teams t ON t.id = tm.team_id
INNER JOIN players p ON p.team_id = t.id
WHERE p.id = 1;

/* Find which team scored the most at ‘LOL’ */
SELECT * FROM teams t
INNER JOIN team_matchs tm ON tm.team_id = t.id
INNER JOIN matchs m ON m.id = tm.match_id
INNER JOIN games g ON g.id = m.game_id
WHERE g.short_name = 'LOL'
AND tm.score = (
	SELECT MAX(score) FROM team_matchs WHERE match_id = m.id
	);
	
SELECT * FROM teams t
INNER JOIN team_matchs tm ON tm.team_id = t.id
INNER JOIN matchs m ON m.id = tm.match_id
INNER JOIN games g ON g.id = m.game_id

WHERE tm.score = (
	SELECT MAX(score) FROM team_matchs WHERE short_name = 'LOL'
	);
	
/* The ‘Team Liquid’ team is now the ‘Team Solid’ team */
UPDATE teams SET NAME = 'Team Solid' 
WHERE id = 1;

UPDATE teams SET NAME = 'Team Solid' 
WHERE name = 'Team Liquid';


/* Set a match as finished by adding the winner_team_id and end_time in a single command. */
UPDATE matchs SET winner_team_id = 1, end_time = NOW()
WHERE id = 1;

/* Update all players names fields to ensure it starts upper case. (This require a little searching effort) */
/* Attetion, test your update request before executing it */
select CONCAT (
	UCASE(
		LEFT(last_name, 1)
		), 
	LCASE(
		SUBSTR(last_name, 2)
		)
	)

FROM players;

/* The actual update request */
UPDATE players SET last_name = CONCAT (
	UCASE(
		LEFT(last_name, 1)
		), 
	LCASE(
		SUBSTR(last_name, 2)
		)
	)
	
/* Add a player to a team and try to delete the team. What happen ? */
DELETE FROM teams WHERE id = 1;
/* Message: cannot delete or update a parent row */

/* Delete the player and try to delete the team. */
DELETE FROM players WHERE team_id = 1;
DELETE FROM teams WHERE id = 1;

/* Delete all games not used in a match. */
/*1. test your request with a select*/
SELECT * FROM games WHERE id NOT IN (
	SELECT DISTINCT(game_id) FROM matchs)
	
/*2. DELETE once your ok with the resul */
DELETE FROM games WHERE id NOT IN (
	SELECT DISTINCT(game_id) FROM matchs)