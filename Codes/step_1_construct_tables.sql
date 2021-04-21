begin;

drop SCHEMA if exists FIFADB;
CREATE SCHEMA FIFADB;
USE FIFADB;

CREATE TABLE player
(
player_id varchar(10),
season varchar(5),
player_name varchar (255),
player_short_name varchar (255),
nationality varchar(255),
height varchar(5),
weight varchar(5),
club_id varchar(10),
loaned_from varchar(255),
wage_eur varchar(10),
value_eur varchar(10),
release_clause varchar(10),
contract_valid_until varchar(5),
team_number varchar(5),
overall varchar(3),
potential varchar(3),
preferred_foot varchar(5),
weak_foot_rating varchar(5),
skill_moves_rating varchar(5)
);

CREATE TABLE player_dob_info
(
player_id varchar(10) unique,
date_of_birth varchar(10)
);

CREATE TABLE country_region
(
country_region_name varchar(255)
);

CREATE TABLE league
(
league_id varchar(10),
season varchar(5),
league_name varchar(255),
tier varchar(5),
country_region_name varchar(255) not null
);

CREATE TABLE club
(
club_id varchar(10),
season varchar(5),
club_name varchar(255),
league_id varchar(10)
);

CREATE TABLE general_player
(
player_id varchar(10),
season varchar(5),
pace varchar(5),
shooting varchar(5),
passing varchar(5),
dribbling varchar(5),
defending varchar(5),
physic varchar(5)
);

CREATE TABLE goalkeeper
(
player_id varchar(10),
season varchar(5),
gk_diving varchar(5),
gk_handling varchar(5),
gk_kicking varchar(5),
gk_reflexes varchar(5),
gk_speed varchar(5),
gk_positioning varchar(5)
);

CREATE TABLE positions
(
position_name varchar(5),
position_class varchar(10)
);

CREATE TABLE tag
(
tag_name varchar(255)
);

CREATE TABLE player_best_position
(
player_id varchar(10),
season varchar(5),
position_name varchar(10)
);

CREATE TABLE player_positional_rating
(
player_id varchar(10),
season varchar(5),
rating varchar(5),
position_name varchar(10)
);

CREATE TABLE player_tag
(

player_id varchar(10),
season varchar(5),
tag_name varchar(255)
);

commit

