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

CREATE TABLE team_matchs(
	team_id BIGINT UNSIGNED NOT NULL,
	match_id BIGINT UNSIGNED NOT NULL,
	score BIGINT NULL DEFAULT NULL,
	PRIMARY KEY (team_id, match_id)
);

CREATE TABLE referees (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `last_name` VARCHAR(255) NOT NULL ,
    `first_name` VARCHAR(255) NOT NULL ,
    PRIMARY KEY(id));

CREATE TABLE games(

 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
 title VARCHAR (75) NOT NULL,
 short_name VARCHAR (10) NOT NULL,
 type VARCHAR (25) NOT NULL,
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
	
ALTER TABLE team_matchs
	ADD CONSTRAINT FOREIGN KEY
	fk_team_matchs_team_id (team_id)
	REFERENCES teams (id)
	/* Si on supprime une team, ça supprime aussi sa participation au match*/
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE team_matchs
	ADD CONSTRAINT FOREIGN KEY
	fk_team_matchs_match_id (match_id)
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
	
	
INSERT INTO referees (last_name, first_name)
values 
("Elmo","Hayato"),
("Moses","Bailey"),
("Miriam","Rice"),
("Gerard","Thompson"),
("Randal","Hammond"),
("Carroll ","Saunders"),
("Molly","Grant"),
("Thelma","Reeves"),
("Anne","Knight"),
("Henrietta","Nichols");

INSERT INTO games (title, short_name, type)
VALUES
("League of Legends","LOL","MOBA"),
("Dota 2","DOTA2","MOBA"),
("Counter-Strike: Global Offensive","CS:GO","FPS"),
("Heartstone","HEARTSTONE","Card game"),
("Heroes of the Storm","HotS","MOBA"),
("Overwatch","OW","FPS"),
("World of Tanks","WoT","Vehicular Combat"),
("StarCraft II","SC2","RTS"),
("Street Fighter V","SF5","Fighting"),
("Super Smash Bross. Melee","SSBM","Fighting");


INSERT INTO teams (name, logo_file, country)
VALUES
("Team Liquid","team-liquid.png","Belgium"),
("OG","og.png","France"),
("Evil Geniuses","evil-geniuses.png","Switzterland"),
("Team Spirit","team-spirit.png","China"),
("Natus Vincere","natus-vincere.png","China"),
("Team Secret","team-secret.png","USA"),
("Fnatic","fnatic.png","Spain"),
("Paris Saint-Germain Esports",NULL,"France"),
("Virtus.pro","virtus-pro.png","Israel"),
("Vici Gaming","vici-gaming.png","Germany");


INSERT INTO rooms (name)
VALUES
("Room 1"),
("Room 2"),
("Room 3"),
("Room 4"),
("Room 5"),
("Room 6"),
("Room 7"),
("Room 8"),
("Room 9"),
("Room 10");


INSERT into matchs (id, start_time, referee_id, room_id, game_id) VALUES
(1, "2023-01-03 09:00:00", 1,1,1),
(2, "2023-01-03 09:00:00",5,3,3),
(3, "2023-01-03 11:00:00", 4,2,10);

INSERT INTO team_matchs (match_id, team_id) VALUES
(1,1), (1,2),
(2,3), (2,4), (2,5),
(3,1), (3,2);

insert into players (id, last_name, first_name, bib_number, team_id) values (1, 'Itskovitz', 'Ikey',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (2, 'Conachie', 'Price',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (3, 'Grigore', 'Doro',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (4, 'Mapples', 'Felecia',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (5, 'Westby', 'Diahann',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (6, 'McSporon', 'Yolanda',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (7, 'Edgler', 'Angus',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (8, 'Simoneau', 'Leta',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (9, 'Gathwaite', 'Janos',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (10, 'Meffin', 'Cecil',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (11, 'Mackieson', 'Deerdre',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (12, 'Klosges', 'Mandel',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (13, 'Fidelli', 'Thorvald',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (14, 'Greenough', 'Randal',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (15, 'Mathivet', 'Marnia',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (16, 'A''field', 'Philis',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (17, 'Sambedge', 'Bruis',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (18, 'Cowser', 'Susana',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (19, 'Coleshill', 'Kristo',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (20, 'Coare', 'Linn',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (21, 'Jorgensen', 'Rikki',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (22, 'Boyet', 'Barnabe',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (23, 'Work', 'Celestyn',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (24, 'Hurche', 'Bucky',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (25, 'Keddy', 'Gunther',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (26, 'Melmar', 'Darwin',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (27, 'Kincla', 'Rocky',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (28, 'Dassindale', 'Joya',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (29, 'Leitch', 'Cornie',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (30, 'Brookes', 'Odey',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (31, 'Plinck', 'Nelie',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (32, 'Scotchbourouge', 'Tybalt',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (33, 'Rau', 'Barret',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (34, 'Chittim', 'Hilary',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (35, 'Veryard', 'Erminie',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (36, 'Cinavas', 'Giustina',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (37, 'Wiltshire', 'Ben',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (38, 'Ferrarello', 'Mufi',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (39, 'Leeburn', 'Jude',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (40, 'Dessent', 'Ina',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (41, 'Mullineux', 'Carmencita',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (42, 'Thirtle', 'Catriona',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (43, 'Kybbye', 'Laurianne',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (44, 'Beningfield', 'Rolf',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (45, 'Siddens', 'Maure',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (46, 'Streatley', 'Gena',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (47, 'Threader', 'Avrom',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (48, 'Canas', 'Wilburt',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (49, 'Josiah', 'Korry',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (50, 'Storie', 'Wake',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (51, 'Knoble', 'Chiquia',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (52, 'Loft', 'Neron',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (53, 'Sales', 'Kleon',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (54, 'Grassi', 'Madella',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (55, 'Stone Fewings', 'Lucine',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (56, 'Carmont', 'Inessa',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (57, 'Pack', 'Morgen',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (58, 'Weatherburn', 'Claudina',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (59, 'Grogono', 'Didi',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (60, 'Comford', 'Debby',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (61, 'Gadaud', 'Odell',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (62, 'Alwood', 'Sheff',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (63, 'Swait', 'Gilberta',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (64, 'Butten', 'Niels',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (65, 'Gerrelt', 'Eulalie',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (66, 'Urian', 'Faydra',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (67, 'Parmby', 'Lorette',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (68, 'Morefield', 'Annissa',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (69, 'O'' Mahony', 'Chandler',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (70, 'Di Baudi', 'Belita',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (71, 'Runchman', 'Nickie',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (72, 'Loughnan', 'Wilhelm',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (73, 'Frany', 'Molli',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (74, 'Jacquest', 'Junina',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (75, 'Kuban', 'Olive',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (76, 'Raeside', 'Lilas',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (77, 'Dangl', 'Kelcey',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (78, 'Meni', 'Wyatan',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (79, 'Delagnes', 'Nelson',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (80, 'Swanton', 'Sullivan',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (81, 'Groomebridge', 'Raychel',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (82, 'Libbey', 'Ardith',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (83, 'Vertigan', 'Arturo',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (84, 'Martynikhin', 'Dell',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (85, 'Colrein', 'Lothario',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (86, 'Atwel', 'Tulley',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (87, 'Cuppitt', 'Henka',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (88, 'Abilowitz', 'Flor',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (89, 'Houtbie', 'Wit',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (90, 'Cleaves', 'Lenette',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (91, 'Rackstraw', 'Hasheem',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (92, 'Capelow', 'Elka',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (93, 'Penddreth', 'Forster',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (94, 'Minall', 'Igor',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (95, 'Drabble', 'Verina',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (96, 'Laphorn', 'Winonah',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (97, 'Maberley', 'Helen-elizabeth',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (98, 'Wase', 'Hannie',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (99, 'Rosle', 'Ferrel',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));
insert into players (id, last_name, first_name, bib_number, team_id) values (100, 'Siveter', 'Byran',  FLOOR(1000 + RAND() * (9999 - 1)),  FLOOR(1+ RAND() * (10- 1)));


