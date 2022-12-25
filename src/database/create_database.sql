drop database if exists esport;
CREATE DATABASE esport CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
use esport;

CREATE TABLE teams(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR (50) NOT NULL,
	logo_file VARCHAR (255) NULL DEFAULT NULL,
	country VARCHAR (75) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE teams_matchs(
	team_id BIGINT UNSIGNED NOT NULL,
	match_id BIGINT UNSIGNED NOT NULL,
	score BIGINT NULL DEFAULT NULL,
	PRIMARY KEY (team_id, match_id)
);

CREATE TABLE referees (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL ,
    `firstname` VARCHAR(255) NOT NULL ,
    PRIMARY KEY(id));

CREATE TABLE games(

 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 title VARCHAR (75) NOT NULL,
 types VARCHAR (25) NOT NULL,
 max_duration INT UNSIGNED,
 PRIMARY KEY(id),
 UNIQUE INDEX `unique_title` (`title`) USING BTREE
 
);

CREATE TABLE `rooms`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(25) NOT NULL,
    PRIMARY KEY (`id`),
	UNIQUE INDEX `unique_name` (`name`) USING BTREE
);


CREATE TABLE matchs(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	start_time datetime NOT NULL,
	end_time datetime NULL DEFAULT NULL,
	winner_team_id BIGINT UNSIGNED NULL DEFAULT NULL,
	referee_id BIGINT UNSIGNED NULL DEFAULT NULL,
	room_id BIGINT UNSIGNED NOT NULL,
	game_id BIGINT UNSIGNED NOT NULL,
	primary key(id)
);

CREATE TABLE players(
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    last_name varchar (50) NOT NULL,
    first_name varchar (50) NOT NULL,
	bib_number varchar (25) NOT NULL,
	team_id  BIGINT UNSIGNED  NULL DEFAULT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE players
    ADD CONSTRAINT FOREIGN KEY
    fk_team_id (team_id)
    REFERENCES teams (id)
	/* impossible de supprimer une team qui contient au moins un player*/
    ON DELETE restrict 
    ON UPDATE restrict;
	
ALTER TABLE teams_matchs
	ADD CONSTRAINT FOREIGN KEY
	fk_teams_matchs_team_id (team_id)
	REFERENCES teams (id)
	/* Si on supprime une team, ça supprime aussi sa participation au match*/
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE teams_matchs
	ADD CONSTRAINT FOREIGN KEY
	fk_teams_matchs_match_id (match_id)
	REFERENCES matchs (id)
	/* Si on supprime un match, ça supprime aussi toutes les participations des équipes*/
	ON DELETE restrict
	ON UPDATE restrict;

ALTER TABLE matchs
	ADD CONSTRAINT FOREIGN KEY
	fk_referees_id (referee_id)
	REFERENCES referees (id)
	/* impossible de supprimer un referree impliqué dans un match */
	ON DELETE restrict
	ON UPDATE restrict;

ALTER TABLE matchs
	ADD CONSTRAINT FOREIGN KEY
	fk_room_id (room_id)
	REFERENCES rooms (id)
	/* impossible de supprimer une room dans laquelle un match à lieu */
	ON DELETE restrict
	ON UPDATE restrict;

ALTER TABLE matchs
	ADD CONSTRAINT FOREIGN KEY
	fk_game_id (game_id)
	REFERENCES games (id)
	/* impossible de supprimer un jeu pour lequel un match est organisé */
	ON DELETE restrict
	ON UPDATE restrict;
	
ALTER TABLE matchs
	ADD CONSTRAINT FOREIGN KEY
	fk_winner_team_id (winner_team_id)
	REFERENCES teams (id)
	/* impossible de supprimer une équipe qui a gagné un match */
	ON DELETE restrict
	ON UPDATE restrict;