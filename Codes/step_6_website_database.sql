CREATE TABLE Admin
(
	ID varchar(10) primary key,
    pwd varchar(20),
    name varchar(10),
    email varchar(10)
);
CREATE TABLE new_player(
player_id varchar(10),
season varchar(5),
player_name varchar (255),
nationality varchar(255),
club_id varchar(10),
overall varchar(3),
potential varchar(3),
primary key(player_Id,season)
);
use FIFADB;
drop table if exists website;
create table website as select player_id,player_name,season,club_id,value_eur,nationality,overall,potential,club_name,position_class from positions natural join player_best_position natural join player natural join club ;
insert into admin values('admin','123456','zsq','118010416@');