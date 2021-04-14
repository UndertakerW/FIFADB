CREATE SCHEMA FIFADB;
USE FIFADB;
CREATE TABLE player
(
player_id varchar(20),
season varchar(5),
player_name varchar (40),
date_of_birth varchar(10),
nationality varchar(20),
height varchar(5),
weight varchar(5),
club_id varchar(10),
loaned_fron varchar(20),
wage_eur varchar(10),
value_eur varchar(20),
release_clause varchar(10),
contract_valid_until varchar(5),
team_number varchar(5),
overall varchar(3),
potential varchar(3),
position varchar(5),
positional_rating varchar(5),
preferred_foot varchar(5),
weak_foot_rating varchar(5),
skill_moves_rating varchar(5),
tag varchar(10),
primary key(player_id,season)
);

CREATE TABLE CLUB(
club_id varchar(10),
season varchar(5),
club_name varchar(40),
league_id varchar(40),
primary key(club_id,season)
);

CREATE TABLE LEAGUE(
league_id varchar(10),
league_name varchar(40),
league_rank varchar(5),
country varchar(10),
primary key (league_id)
);

create table country(
country_name varchar(10) primary key

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
physic varchar(5),
foreign key (player_id,season) references player(player_id,season)
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
physic varchar(5),
foreign key (player_id,season) references player(player_id,season)
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
gk_positioning varchar(5),
foreign key (player_id,season) references player(player_id,season)
);

create table positions
(
position_name varchar(5) primary key
);


create table tag
(
tag_name varchar(10) primary key
);


create table player_club
(
player_id varchar(20),
season varchar(5),
club_id varchar(10) not null,
joined_time varchar(10),
primary key(player_id,season,club_id),
foreign key(player_id,season) references player(player_id,season),
foreign key(club_id) references club(club_id)

);

create table player_loan_from
(
player_id varchar(20),
season varchar(5),
club_id varchar(10),
primary key(player_id,season,club_id),
foreign key(player_id,season) references player(player_id,season),
foreign key(club_id) references club(club_id)
);


create table club_league
(
league_id varchar(10) not null,
season varchar(5),
club_id varchar(10),
primary key(league_id,season,club_id),
foreign key(league_id) references league(league_id),
foreign key(club_id,season) references club(club_id,season)

);

create table league_country
(
league_id varchar(10),
country_name varchar(10) not null,
primary key(league_id,country_name),
foreign key(league_id) references league(league_id),
foreign key(country_name) references country(country_name)
);

create table player_country
(
player_id varchar(20),
season varchar(5),
country_name varchar(10) not null,
primary key(player_id,season,country_name),
foreign key(player_id,season) references player(player_id,season),
foreign key(country_name) references country(country_name)
);


create table player_best_position
(
player_id varchar(20),
season varchar(5),
position_name varchar(10),
primary key(player_id,season,position_name),
foreign key(player_id,season) references player(player_id,season),
foreign key(position_name) references positions(position_name)
);

create table player_positional_rating
(

player_id varchar(20),
season varchar(5),
rating varchar(5),
position_name varchar(10),
primary key(player_id,season,position_name),
foreign key(player_id,season) references player(player_id,season),
foreign key(position_name) references positions(position_name)
);


create table player_tag
(

player_id varchar(20),
season varchar(5),
tag_name varchar(10),
primary key(player_id,season,tag_name),
foreign key(player_id,season) references player(player_id,season),
foreign key(tag_name) references tag(tag_name)
);

commit

