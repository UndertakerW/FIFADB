-- The total salaries of the BIG 6 clubs of English Premiere League from season 14/15 to 20/21
drop table if exists wage_epl6;
create table wage_epl6 as
select club_name, player.season, sum(wage_eur)
from player join club using(club_id, season)
where club_name in ("Arsenal", "Chelsea", "Tottenham Hotspur", "Manchester United", "Manchester City", "Liverpool")
group by club_name, player.season;

select * 
from wage_epl6;

-- The rank of clubs in each of the "Big Five" European football leagues in terms of the total value of players in season 20/21
drop table if exists club_wage_20_21;
create table club_wage_20_21 as
select league_id, league_name, club_id, club_name, sum(wage_eur) as total_wage_eur
from player join club using(club_id, season) join league using (league_id, season)
where season = "20/21"
and tier = 1
and league.country_region_name in ("England", "Germany", "France", "Italy", "Spain")
group by club_id;

select league_name, club_name, total_wage_eur,
rank() over (partition by league_id order by total_wage_eur desc) as "rank"
from club_wage_20_21;

-- The average ratings of forwards, midfielders, defenders (including goalkeepers) of the BIG 3 clubs of La Liga in season 18-19, 19-20, and 20-21
-- Assuming each player plays in his best position (where he has the highest rating)
-- If a player has the same rating in two or more positions that belong to different classes,
-- e.g. LW -> forward and CM -> midfielder,
-- then, he will be counted in both classes.

drop table if exists player_best_rating;
create table player_best_rating as
select player_id, season, max(rating) as best_rating
from player join club using(club_id, season) join player_positional_rating using(player_id, season) join general_player using(player_id, season)
where season in ("18/19", "19/20", "20/21")
and club_name in ("Real Madrid", "FC Barcelona", "Atlético Madrid")
group by player_id, season;

drop table if exists player_best_position_class;
create table player_best_position_class as
select distinct player_id, season, player_name, club_id, club_name, position_class, rating as player_best_rating
from player join club using(club_id, season) join player_positional_rating using (player_id, season) 
join positions using (position_name) join player_best_rating using (player_id, season)
where season in ("18/19", "19/20", "20/21")
and club_name in ("Real Madrid", "FC Barcelona", "Atlético Madrid")
and rating = best_rating;

insert into player_best_position_class
select player_id, season, player_name, club_id, club_name, "defender" as position_class, overall as player_best_rating
from player join club using(club_id, season) join goalkeeper using(player_id, season)
where season in ("18/19", "19/20", "20/21")
and club_name in ("Real Madrid", "FC Barcelona", "Atlético Madrid");

select * from player_best_position_class;

select club_name, season, position_class,
avg(player_best_rating) as "average rating"
from player_best_position_class
group by club_name, season, position_class with rollup;







-- others
-- Market Value vs Age
drop table if exists market_value_age;
create table market_value_age
select season, timestampdiff(year, cast(date_of_birth as date), cast((concat(concat('20',substring(season,1,2)),'/09/01')) as date)) as age, value_eur
from player join player_dob_info using(player_id);

select *
from market_value_age
order by value_eur;

select age, avg(value_eur)
from market_value_age
group by age
order by age;

select 
	(avg(age * value_eur) 
    - avg(age) * avg(value_eur)) 
    / (sqrt(avg(age * age) 
    - avg(age) * avg(age)) 
    * sqrt(avg(value_eur * value_eur) 
    - avg(value_eur) * avg(value_eur))) 
as pcc
from market_value_age
where (age regexp '[^0-9.]') = 0 
and (value_eur regexp '[^0-9.]') = 0
and age < 27;

-- Overall Rating vs Age
drop table if exists overall_age;
create table overall_age
select season, timestampdiff(year, cast(date_of_birth as date), cast((concat(concat('20',substring(season,1,2)),'/09/01')) as date)) as age, overall
from player join player_dob_info using(player_id);


select age, avg(overall)
from overall_age
group by age
order by age;


-- Wage vs Age
drop table if exists wage_age;
create table wage_age
select season, timestampdiff(year, cast(date_of_birth as date), cast((concat(concat('20',substring(season,1,2)),'/09/01')) as date)) as age, wage_eur
from player join player_dob_info using(player_id);


select age, avg(wage_eur)
from wage_age
group by age
order by age;

select 
	(avg(age * wage_eur) 
    - avg(age) * avg(wage_eur)) 
    / (sqrt(avg(age * age) 
    - avg(age) * avg(age)) 
    * sqrt(avg(wage_eur * wage_eur) 
    - avg(wage_eur) * avg(wage_eur))) 
as pcc
from wage_age
where (age regexp '[^0-9.]') = 0 
and (wage_eur regexp '[^0-9.]') = 0
and age < 26;

-- Wage vs Age EPL
drop table if exists wage_age_epl;
create table wage_age_epl
select player.season, timestampdiff(year, cast(date_of_birth as date), cast((concat(concat('20',substring(season,1,2)),'/09/01')) as date)) as age, wage_eur
from player join player_dob_info using(player_id) join club using(club_id, season) join league using (league_id, season)
where league_name = "English Premier League";

select age, avg(wage_eur)
from wage_age_epl
group by age
order by age;

select 
	(avg(age * wage_eur) 
    - avg(age) * avg(wage_eur)) 
    / (sqrt(avg(age * age) 
    - avg(age) * avg(age)) 
    * sqrt(avg(wage_eur * wage_eur) 
    - avg(wage_eur) * avg(wage_eur))) 
as pcc
from wage_age_epl
where (age regexp '[^0-9.]') = 0 
and (wage_eur regexp '[^0-9.]') = 0
and age < 24;