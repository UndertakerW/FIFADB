create table Admin
(
	ID varchar(10) primary key,
    pwd varchar(20),
    name varchar(10),
    email varchar(10)
);
insert into admin values('admin','123456','zsq','118010416@');

create table new_player(
player_id varchar(10),
season varchar(5),
player_name varchar (255),
nationality varchar(255),
club_id varchar(10),
overall varchar(3),
potential varchar(3),
primary key(player_Id,season)
);

create table website_table 
	select player.*, club.club_name, player_best_position.position_name
    from player natural join club natural join player_best_position;
    
alter table website_table add primary key (player_id, season, position_name);