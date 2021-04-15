begin;

drop SCHEMA if exists FIFADB;
CREATE SCHEMA FIFADB;
USE FIFADB;

drop table if exists player;
CREATE TABLE player
(
player_id varchar(20),
season varchar(5),
player_name varchar (40),
nationality varchar(20),
height varchar(5),
weight varchar(5),
club_id varchar(20),
loaned_from varchar(20),
wage_eur varchar(10),
value_eur varchar(20),
release_clause varchar(10),
contract_valid_until varchar(5),
team_number varchar(5),
overall varchar(3),
potential varchar(3),
preferred_foot varchar(5),
weak_foot_rating varchar(5),
skill_moves_rating varchar(5),
tag varchar(10)
-- primary key(player_id,season)
);

CREATE TABLE player_dob_info
(
player_id varchar(20) unique,
date_of_birth varchar(10)
-- primary key(player_id),
-- foreign key(player_id) references player(player_id)
);

CREATE TABLE country
(
country_name varchar(10) -- primary key
);

CREATE TABLE league
(
league_id varchar(10),
league_name varchar(40),
tier varchar(5),
country varchar(10)
-- primary key (league_id),
-- foreign key(country) references country(country_name)
);

CREATE TABLE club
(
club_id varchar(20),
season varchar(5),
club_name varchar(40),
league_id varchar(40)
-- primary key(club_id,season),
-- foreign key(league_id) references league(league_id)
);

CREATE TABLE general_player
(
player_id varchar(20),
season varchar(5),
pace varchar(5),
shooting varchar(5),
passing varchar(5),
dribbling varchar(5),
defending varchar(5),
physic varchar(5)
-- primary key(player_id,season),
-- foreign key (player_id,season) references player(player_id,season)
);

CREATE TABLE goalkeeper
(
player_id varchar(20),
season varchar(5),
gk_diving varchar(5),
gk_handling varchar(5),
gk_kicking varchar(5),
gk_reflexes varchar(5),
gk_speed varchar(5),
gk_positioning varchar(5)
-- primary key(player_id,season),
-- foreign key (player_id,season) references player(player_id,season)
);

CREATE TABLE positions
(
position_name varchar(5) -- primary key
);

CREATE TABLE tag
(
tag_name varchar(10) -- primary key
);

CREATE TABLE player_best_position
(
player_id varchar(20),
season varchar(5),
position_name varchar(10)
-- primary key(player_id,season),
-- foreign key(player_id,season) references player(player_id,season),
-- foreign key(position_name) references positions(position_name)
);

CREATE TABLE player_positional_rating
(
player_id varchar(20),
season varchar(5),
rating varchar(5),
position_name varchar(10)
-- primary key(player_id,season,position_name),
-- foreign key(player_id,season) references player(player_id,season),
-- foreign key(position_name) references positions(position_name)
);

CREATE TABLE player_tag
(

player_id varchar(20),
season varchar(5),
tag_name varchar(10)
-- primary key(player_id,season,tag_name),
-- foreign key(player_id,season) references player(player_id,season),
-- foreign key(tag_name) references tag(tag_name)
);

alter table player add foreign key(nationality) references country(country_name);
alter table player add foreign key(club_id) references club(club_id);
commit

