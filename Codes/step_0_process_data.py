# important notice:
# In this script, some variables' names may use "country" to reprenset
# the values of countries and regions. We only use these representation
# for simplicity and we donnot have any political intentions on it. 
# Hope it will not cause any misundertanding.
#
# To run the script:
# 1. you need to install python and numpy package.
# 2. you need to run the script in the given folder.

import os
import numpy as np
import csv

def split_string(string):
    temp_result = string.split(',')
    result = []

    for item in temp_result:
        result.append(item.strip())

    return result

def cleanString(string):
    tempResult = string.split('+')
    return tempResult[0]

def processContract(string):
    year = ""
    if(string != ""):
        year = string[2:]
        year_int = int(year)
        year = str(year_int-1)+"/"+str(year_int)
    
    return year

dataFolder = "../Data/Data_encoded/"
newDataFolder = "../Data/Data_processed/"

fileNamePre  = "players_"
fileNameSuff = ".csv"

player_table = "player.csv"
general_player_table = "general_player.csv"
goalkeeper_table = "goalkeeper.csv"
player_best_position_table = "player_best_position.csv"
player_dob_info_table = "player_dob_info.csv"
tag_table = "tag.csv"
player_tag_table = "player_tag.csv"
positions_table = "positions.csv"
club_table = "club.csv"
league_table = "league.csv"
player_positional_rating_table = "player_positional_rating.csv"
country_region_table = "country_region.csv"

position_name = []
tag_index = 25
position_index = 16
player_id_index = 0
player_name_index = 3
player_name_short_index = 2
nationality_index = 8
height_index = 6
weight_index = 7
loaned_index = 28
wage_index = 15
value_index = 14
release_clause_index = 24
contract_index = 30
team_number_index = 27
overall_index = 12
potential_index = 13
preferred_foot_index = 17
weak_foot_index = 19
skill_moves_index = 20
pace_index = 33
shooting_index = 34
passing_index = 35
dribbing_index = 51
defending_index = 37
physic_index = 38
gk_diving_index = 39
gk_handling_index = 40
gk_kicking_index = 41
gk_reflexes_index = 42
gk_speed_index = 43
gk_positioning = 44
dob_index = 5
league_name_index = 10
tier_index = 11
club_name_index = 9

small_tables = [
    player_table,
    general_player_table,
    goalkeeper_table,
    player_best_position_table,
    player_dob_info_table,
    tag_table,
    player_tag_table,
    positions_table,
    club_table,
    league_table,
    player_positional_rating_table,
    country_region_table
]

player_indexes = [
    
]

league_names = []
league_file_name = "leagues.csv"

league_id = {}
club_id = {}

league_id_cnt = 0
club_id_cnt = 0

league_country_map = {}

position_rating_col_num = {}

country_list_temp = []


for item in small_tables:
    if(os.path.exists(newDataFolder+item)):
        os.remove(newDataFolder+item)
        print("removing old version file: "+newDataFolder+item)


# retrieve the league names to map the country manully
# retrieve the country names from the nationality of player
for i in range(15, 22):
    with open(dataFolder+fileNamePre+str(i)+fileNameSuff, 'rt', encoding='utf-8-sig', newline='') as pf:
        pfr = csv.reader(pf)
        first_row = True
        for row in pfr:
            if(first_row):
                first_row = False
                continue
            
            # collect the country from the nationality of the players
            if(row[nationality_index].strip() not in country_list_temp):
                country_list_temp.append(row[nationality_index].strip())


# collect country of the leagues
with open(dataFolder+"leagues_countries.csv", 'rt', encoding='utf-8-sig', newline='') as cf:
    cfr = csv.reader(cf)

    for row in cfr:
        league_country_map[row[0]] = row[1]
        if(row[1].strip() not in country_list_temp):
            country_list_temp.append(row[1].strip())


# country
countryf = open(newDataFolder+country_region_table, 'wt', encoding="utf-8-sig", newline='')
countryfw = csv.writer(countryf)
for item in country_list_temp:
    countryfw.writerow([item])
countryf.close()


# position
positions_table_f = open(newDataFolder+positions_table, 'wt', encoding='utf-8-sig', newline='')
positf = csv.writer(positions_table_f)

with open(dataFolder+fileNamePre+str(15)+fileNameSuff, 'rt', encoding='utf-8-sig', newline='') as of:
    ofr = csv.reader(of)
    
    for row in ofr:
        titles = row
        for i in range(80, 106):
            positf.writerow([titles[i].lower()])
            position_rating_col_num[i] = titles[i]

        break

positf.writerow(["gk"])

positions_table_f.close()

# processing "league" and "club" first
with open(newDataFolder+league_table, 'wt', encoding='utf-8-sig', newline='') as lf:
    with open(newDataFolder+club_table, 'wt', encoding='utf-8-sig', newline='') as cf:
        lfw = csv.writer(lf)
        cfw = csv.writer(cf)

        # open all the origianl excel files
        for i in range(15, 22):
            season_league = []
            season_club = []

            fileName = fileNamePre + str(i) + fileNameSuff
            originalFileName = dataFolder+fileName

            if (not os.path.exists(originalFileName)):
                print("not find file: "+originalFileName)
                continue

            with open(originalFileName, 'rt', encoding='utf-8-sig', newline='') as of:
                season = str(i-1)+"/"+str(i)

                ofr = csv.reader(of)

                first_row = True

                for row in ofr:
                    if(first_row):
                        first_row = False
                        continue

                    if(row[league_name_index] not in league_id):
                        # print("adding key: "+row[league_name_index])
                        league_id[row[league_name_index]] = league_id_cnt
                        season_league.append(row[league_name_index])
                        lfw.writerow([league_id_cnt, season, row[league_name_index], row[tier_index], league_country_map[row[league_name_index]]])
                        league_id_cnt += 1

                    elif(row[league_name_index] not in season_league):
                        season_league.append(row[league_name_index])
                        lfw.writerow([league_id[row[league_name_index]], season, row[league_name_index], row[tier_index], league_country_map[row[league_name_index]]])


                    if(row[club_name_index] not in club_id):
                        # print("adding key: "+row[club_name_index])
                        club_id[row[club_name_index]] = club_id_cnt
                        season_club.append(row[club_name_index])
                        cfw.writerow([club_id_cnt, season, row[club_name_index], league_id[row[league_name_index]]])
                        club_id_cnt += 1

                    elif(row[club_name_index] not in season_club):
                        season_club.append(row[club_name_index])
                        cfw.writerow([club_id[row[club_name_index]], season, row[club_name_index], league_id[row[league_name_index]]])


tag_table_f                 = open(newDataFolder+tag_table, 'wt', encoding='utf-8-sig', newline='')
player_table_f              = open(newDataFolder+player_table, 'wt', encoding='utf-8-sig', newline='')
general_player_table_f      = open(newDataFolder+general_player_table, 'wt', encoding='utf-8-sig', newline='')
goalkeeper_table_f          = open(newDataFolder+goalkeeper_table, 'wt', encoding='utf-8-sig', newline='') 
player_dob_info_table_f     = open(newDataFolder+player_dob_info_table, 'wt', encoding='utf-8-sig', newline='')
player_tag_table_f          = open(newDataFolder+player_tag_table, 'wt', encoding='utf-8-sig', newline='')
player_best_position_table_f        = open(newDataFolder+player_best_position_table, 'wt', encoding='utf-8-sig', newline='')
player_positional_rating_table_f    = open(newDataFolder+player_positional_rating_table, 'wt', encoding='utf-8-sig', newline='')

ttf     = csv.writer(tag_table_f)
playtf  = csv.writer(player_table_f)
gpf     = csv.writer(general_player_table_f)
gtf     = csv.writer(goalkeeper_table_f)
pditf   = csv.writer(player_dob_info_table_f)
pttf    = csv.writer(player_tag_table_f)
pbptf   = csv.writer(player_best_position_table_f)
pprtf   = csv.writer(player_positional_rating_table_f)

tag_name = []

player_dob_list = []

for i in range(15, 22):
    fileName = fileNamePre + str(i) + fileNameSuff
    of = open(dataFolder+fileName, 'rt', encoding='utf-8-sig', newline='')
    season = str(i-1)+"/"+str(i)

    ofr = csv.reader(of)

    first_row = True

    for row in ofr:
        if(first_row):
            first_row = False
            continue

        # tag
        row_tag = split_string(row[tag_index])
        for item in row_tag:
            if(item not in tag_name):
                tag_name.append(item)
                ttf.writerow([item])
            
            # player_tag
            if(item != ""):
                pttf.writerow([
                    row[player_id_index],
                    season,
                    item
                ])

        
        # player_best_position
        row_best_posis = split_string(row[position_index])
        for item in row_best_posis:
            if(item != ""):
                pbptf.writerow([
                    row[player_id_index],
                    season,
                    item.lower()
                ])

        
        # player
        playtf.writerow([
            row[player_id_index],
            season,
            row[player_name_index],
            row[player_name_short_index],
            row[nationality_index],
            row[height_index],
            row[weight_index],
            club_id[row[club_name_index]],
            row[loaned_index],
            row[wage_index],
            row[value_index],
            row[release_clause_index],
            processContract(row[contract_index]),
            row[team_number_index],
            row[overall_index],
            row[potential_index],
            row[preferred_foot_index],
            row[weak_foot_index],
            row[skill_moves_index]
        ])

        # goalkeeper
        if(row[gk_diving_index] != ""):
            gtf.writerow([
                row[player_id_index],
                season,
                row[gk_diving_index],
                row[gk_handling_index],
                row[gk_kicking_index],
                row[gk_reflexes_index],
                row[gk_speed_index],
                row[gk_positioning],
            ])
        # general player
        else:
            gpf.writerow([
                row[player_id_index],
                season,
                row[pace_index],
                row[shooting_index],
                row[passing_index],
                row[dribbing_index],
                row[defending_index],
                row[physic_index]
            ])
            

        # player_dob_info
        # only need to record once for each player
        if(row[player_id_index] not in player_dob_list):
            player_dob_list.append(row[player_id_index])
            pditf.writerow([
                row[player_id_index],
                row[dob_index]
            ])

        # player_positional_rating
        for posi_attr_rating_col in range(80, 106):
            pprtf.writerow([
                row[player_id_index],
                season,
                cleanString(row[posi_attr_rating_col]),
                position_rating_col_num[posi_attr_rating_col]
            ])



tag_table_f.close()
player_table_f.close()
general_player_table_f.close()
goalkeeper_table_f.close()
player_dob_info_table_f.close()
player_tag_table_f.close()
player_best_position_table_f.close()
player_positional_rating_table_f.close()