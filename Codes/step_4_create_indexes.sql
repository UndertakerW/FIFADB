-- turn on innodb adaptive hash index mechanism
set global innodb_adaptive_hash_index = ON;

-- player
ALTER TABLE player ADD INDEX player_player_id_index (player_id);
ALTER TABLE player ADD INDEX player_season_index (season);
ALTER TABLE player ADD INDEX player_player_name_index (player_name);
ALTER TABLE player ADD INDEX player_player_short_name_index (player_short_name);
ALTER TABLE player ADD INDEX player_nationality_index (nationality);
ALTER TABLE player ADD INDEX player_club_id_index (club_id);

-- club
ALTER TABLE club ADD INDEX club_club_id_index (club_id);
ALTER TABLE club ADD INDEX club_season_index (season);
ALTER TABLE club ADD INDEX club_club_name_index (club_name);
ALTER TABLE club ADD INDEX club_league_id_index (league_id);

-- league
ALTER TABLE league ADD INDEX league_league_id_index (league_id);
ALTER TABLE league ADD INDEX league_season_index (season);
ALTER TABLE league ADD INDEX league_league_name_index (league_name);
ALTER TABLE league ADD INDEX league_country_region_name_index (country_region_name);

-- player_positional_rating
ALTER TABLE player_positional_rating ADD INDEX player_positional_rating_player_id_index (player_id);
ALTER TABLE player_positional_rating ADD INDEX player_positional_rating_season_index (season);
ALTER TABLE player_positional_rating ADD INDEX player_positional_position_name_index (position_name);

-- player_best_position
ALTER TABLE player_best_position ADD INDEX player_best_position_player_id_index (player_id);
ALTER TABLE player_best_position ADD INDEX player_best_position_season_index (season);
ALTER TABLE player_best_position ADD INDEX player_best_position_name_index (position_name);




-- test sample:
-- query with index

FLUSH TABLES;
FLUSH STATUS;
-- it takes around 0.047 sec to execute the following query
select SQL_NO_CACHE * from player where player_name like 'Ales%' and player_short_name like 'A.%' and season = '16/17' and nationality = 'Italy';

-- query without indexes
-- drop indexes
drop index player_season_index on player;
drop index player_player_name_index on player;
drop index player_player_short_name_index on player;

FLUSH TABLES;
FLUSH STATUS;
-- it takes around 0.125 sec to execute the same query
select SQL_NO_CACHE * from player where player_name like 'Ales%' and player_short_name like 'A.%' and season = '16/17' and nationality = 'Italy';


-- reset indexes back
alter table player add index player_season_index (season);
alter table player add index player_player_name_index (player_name);
alter table player add index player_player_short_name_index (player_short_name);