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
insert into admin values('admin','123456','zsq','118010416@');