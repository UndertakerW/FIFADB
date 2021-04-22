begin;

-- set Innodb to create adaptive hash index
set global innodb_adaptive_hash_index = ON;

-- clean abnormal value
SET SQL_SAFE_UPDATES = 0;
update player set player_id = "158023" where player_id = "158023";
update player set release_clause = null where release_clause = "";
update player set nationality = null where nationality = "";
update player set loaned_from = null where loaned_from = "";
update player set team_number = null where team_number = "";
update club set club_id = "0" where club_id = "0";
update general_player set player_id = "158023" where player_id = "158023";
update goalkeeper set player_id = "167495" where player_id = "167495";
update league set league_id = "0" where league_id = "0";
update league set tier = null where tier = "";
update player_best_position set player_id = "158023" where player_id = "158023";
update player_dob_info set player_id = "158023" where player_id = "158023";
update player_positional_rating set player_id = "158023" where player_id = "158023";
update player_tag set player_id = "158023" where player_id = "158023";

-- convert varchar to int
-- 1. player
alter table player modify height INTEGER;
alter table player modify weight INTEGER;
alter table player modify wage_eur INTEGER;
alter table player modify club_id INTEGER;
alter table player modify player_id INTEGER;
alter table player modify wage_eur INTEGER;
alter table player modify value_eur INTEGER;
alter table player modify release_clause INTEGER;
alter table player modify team_number INTEGER;
alter table player modify overall INTEGER;
alter table player modify potential INTEGER;
alter table player modify weak_foot_rating INTEGER;
alter table player modify skill_moves_rating INTEGER;

-- 2. club
alter table club modify club_id INTEGER;
alter table club modify league_id INTEGER;

-- 3. general_player
alter table general_player modify player_id INTEGER;
alter table general_player modify pace INTEGER;
alter table general_player modify shooting INTEGER;
alter table general_player modify passing INTEGER;
alter table general_player modify dribbling INTEGER;
alter table general_player modify defending INTEGER;
alter table general_player modify physic INTEGER;

-- 4. goalkeeper
alter table goalkeeper modify player_id INTEGER;
alter table goalkeeper modify gk_diving INTEGER;
alter table goalkeeper modify gk_handling INTEGER;
alter table goalkeeper modify gk_kicking INTEGER;
alter table goalkeeper modify gk_reflexes INTEGER;
alter table goalkeeper modify gk_speed INTEGER;
alter table goalkeeper modify gk_positioning INTEGER;

-- 5. league
alter table league modify league_id INTEGER;
alter table league modify tier INTEGER;

-- 6. player_best_position
alter table player_best_position modify player_id INTEGER;

-- 7. player_dob_info
alter table player_dob_info modify player_id INTEGER;

-- 8. player_positional_rating
alter table player_positional_rating modify player_id INTEGER;
alter table player_positional_rating modify rating INTEGER;

-- 9. player_tag
alter table player_tag modify player_id INTEGER;


-- set primary keys
alter table player add primary key(player_id, season);
alter table player_dob_info add primary key(player_id);
alter table country_region add primary key(country_region_name);
alter table league add primary key(league_id, season);
alter table club add primary key(club_id, season);
alter table general_player add primary key(player_id, season);
alter table goalkeeper add primary key(player_id, season);
alter table positions add primary key(position_name);
alter table tag add primary key(tag_name);
alter table player_best_position add primary key(player_id, season, position_name);
alter table player_positional_rating add primary key(player_id, season, position_name);
alter table player_tag add primary key(player_id, season, tag_name);

-- set foreign keys
alter table player add foreign key(club_id) references club(club_id) on delete cascade on update cascade;
alter table player add foreign key(nationality) references country_region(country_region_name) on delete cascade on update cascade;
alter table player_dob_info add foreign key(player_id) references player(player_id) on delete cascade on update cascade;
alter table league add foreign key(country_region_name) references country_region(country_region_name) on delete cascade on update cascade;
alter table club add foreign key(league_id) references league(league_id) on delete cascade on update cascade;
alter table general_player add foreign key (player_id,season) references player(player_id,season) on delete cascade on update cascade;
alter table goalkeeper add foreign key (player_id,season) references player(player_id,season) on delete cascade on update cascade;
alter table player_best_position add foreign key(player_id,season) references player(player_id,season) on delete cascade on update cascade;
alter table player_best_position add foreign key(position_name) references positions(position_name) on delete cascade on update cascade;
alter table player_positional_rating add foreign key(player_id,season) references player(player_id,season) on delete cascade on update cascade;
alter table player_positional_rating add foreign key(position_name) references positions(position_name) on delete cascade on update cascade;
alter table player_tag add foreign key(player_id,season) references player(player_id,season) on delete cascade on update cascade;
alter table player_tag add foreign key(tag_name) references tag(tag_name) on delete cascade on update cascade;

-- set constraints for attributes
alter table player add constraint player_check_potential_overall check(potential >= overall);
alter table player add constraint player_check_potential check(potential >= 1 and potential <= 99);
alter table player add constraint player_check_overall check(overall >= 1 and overall <= 99);
alter table player add constraint player_check_team_number check(team_number >= 0 and team_number <= 99);
alter table player add constraint player_check_preferred_foot check(preferred_foot in ('left', 'right'));
alter table player add constraint player_check_weak_foot_rating check(weak_foot_rating >= 1 and weak_foot_rating <= 5);
alter table player add constraint player_check_skill_moves_rating check(skill_moves_rating >= 1 and skill_moves_rating <= 5);
alter table general_player add constraint general_player_check_pace check(pace >= 1 and pace <= 99);
alter table general_player add constraint general_player_check_shooting check(shooting >= 1 and shooting <= 99);
alter table general_player add constraint general_player_check_passing check(passing >= 1 and passing <= 99);
alter table general_player add constraint general_player_check_dribbling check(dribbling >= 1 and dribbling <= 99);
alter table general_player add constraint general_player_check_defending check(defending >= 1 and defending <= 99);
alter table general_player add constraint general_player_check_physic check(physic >= 1 and physic <= 99);
alter table goalkeeper add constraint goalkeeper_check_gk_diving check(gk_diving >= 1 and gk_diving <= 99);
alter table goalkeeper add constraint goalkeeper_check_gk_handling check(gk_handling >= 1 and gk_handling <= 99);
alter table goalkeeper add constraint goalkeeper_check_gk_kicking check(gk_kicking >= 1 and gk_kicking <= 99);
alter table goalkeeper add constraint goalkeeper_check_gk_reflexes check(gk_reflexes >= 1 and gk_reflexes <= 99);
alter table goalkeeper add constraint goalkeeper_check_gk_speed check(gk_speed >= 1 and gk_speed <= 99);
alter table goalkeeper add constraint goalkeeper_check_gk_positioning check(gk_positioning >= 1 and gk_positioning <= 99);

-- set the updates to safe
SET SQL_SAFE_UPDATES = 1;

commit;
