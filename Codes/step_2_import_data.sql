begin;

-- club
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/club.csv'
into table club
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- country_region
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/country_region.csv'
into table country_region
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- general_player
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/general_player.csv'
into table general_player
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- goalkeeper
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/goalkeeper.csv'
into table goalkeeper
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- league
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/league.csv'
into table league
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- player
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/player.csv'
into table player
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- player_best_position
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/player_best_position.csv'
into table player_best_position
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- player_dob_info
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/player_dob_info.csv'
into table player_dob_info
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- player_positional_rating
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/player_positional_rating.csv'
into table player_positional_rating
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- player_tag
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/player_tag.csv'
into table player_tag
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- positions
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/positions.csv'
into table positions
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- tag
load data
-- need to change to your local path when importing data
infile 'D:/FIFADB/Data/Data_processed/tag.csv'
into table tag
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

commit;