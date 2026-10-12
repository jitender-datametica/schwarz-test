/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_WEEK
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Adv.Period Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-20 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.2  2022-03-16 Andreas Kurz		Changed ADV_WEEK_START_DAY_ID --> CTR_ADV_WEEK_START_WEEKDAY_ID
#  1.3 	2022-03-25 Andreas Kurz		Added more description columns based on Techn. Konzept
#									Some changes on DESC Format
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
ADV_WEEK_YEAR_ID
ADV_WEEK_WEEK_NR
ADV_WEEK_DESCR
ADV_WEEK_LDESCR
ADV_WEEK_SDESCR
ADV_WEEK_OVERLAP_LDESCR

*/


-- Mo.
 -- Montag
 -- AKU 2022-03-25 Added based on Techn. Konzept
 -- Mo.

-- AKU 2022-01-18 Should be kept but is part of the params, best to load via join

-- PROCESSED_ADV_WEEK_ID_FG 1::=ADV_WEEK Was processed; 0::=artifical generated
 -- based on ISO mon ::= 1

-- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_adv_week (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
ctr_adv_week_start_weekday_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Start Day Id of the Adv-Week per Country. E.g. CH=4; based on ISO Kaleneder Mon::=1,..,Sun::=7'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Adv.Week ID e.g. 202137 for week 37 of 2021'),
adv_week_start_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Start DATE of Adv-Week'),
adv_week_end_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='End DATE of Adv.-Week'),
adv_week_start_day_sdescr STRING(16777216)
OPTIONS(description='German short description of the week day, when this adv week starts. Mo. = Montag (Monday)'),
adv_week_end_day_sdescr STRING(16777216)
OPTIONS(description='German short description of the week day, when this adv week ends. Mo. = Montag (Monday)'),
adv_week_start_day_descr STRING(16777216)
OPTIONS(description='German long description of the week day, when this adv week starts. Montag (Monday)'),
adv_week_end_day_descr STRING(16777216)
OPTIONS(description='German long description of the week day, when this adv week ends. Montag (Monday)'),
prev_1_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 1 Adv.Week ID e.g. 202124 --> 202123'),
prev_2_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 2 Adv.Week ID e.g. 202124 --> 202122'),
prev_3_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 3 Adv.Week ID e.g. 202124 --> 202121'),
prev_4_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 4 Adv.Week ID e.g. 202124 --> 202120'),
prev_5_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 5 Adv.Week ID e.g. 202124 --> 202119'),
prev_6_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 6 Adv.Week ID e.g. 202124 --> 202118'),
prev_7_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 7 Adv.Week ID e.g. 202124 --> 202117'),
prev_8_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 8 Adv.Week ID e.g. 202124 --> 202116'),
prev_9_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 9 Adv.Week ID e.g. 202124 --> 202115'),
next_1_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Next 1 Adv.Week ID e.g. 202124 --> 202125'),
prev_1_year_adv_week_id INTEGER DEFAULT 888853 OPTIONS(description='Previous 1 Year Adv.Week ID e.g. 202124 --> 202024'),
processed_adv_week_fg INTEGER DEFAULT 0
OPTIONS(description='Indicator if the Adv.-Week is processed by PIT. 1::=ADV_WEEK Was processed; 0::=artifical generated. Adv-Week Data based on Calendar Data.'),
last_closed_adv_week_id INTEGER DEFAULT 888853 NOT NULL
OPTIONS(description='Week Id of the last Closed Adv.-Week per PIT Country'),
last_adv_week_id INTEGER DEFAULT 888853 NOT NULL
OPTIONS(description='Week Id of the last processed Adv.-Week per PIT Country, which is not closed.'),
last_adv_week_fg INTEGER DEFAULT 0
OPTIONS(description='Indicator if the Adv.-Week is the last processed Adv.-Week per PIT Country. 1::=last Adv.-Weel. 0::=not last Adv.-Week.'),
last_closed_adv_week_fg INTEGER DEFAULT 0
OPTIONS(description='Indicator if the Adv.-Week is the last closed Adv.-Week per PIT Country. 1::=last closed Adv.-Weel. 0::=not last closed Adv.-Week.'),
mov_adv_week_start_from_current INTEGER DEFAULT - 1
OPTIONS(description='Current Adv.-Week is ::0 , pervious Adv.-Week is -1 Next Adv. Week is +1'),
mov_adv_week_id_from_start_nr INTEGER DEFAULT - 1
OPTIONS(description='Calculated RowNumber Adv.-Week from Start. First Row is marked with 0'),
max_adv_period_end_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Maximum assigned Adv. Period End DATE, in case of OVERlapping period. Needed for Reporting Information Window.'),
max_adv_period_end_day_sdescr STRING(16777216)
OPTIONS(description='German short description of the week day, when the max. adv week period ends. Fr. = Freitag (Friday)'),
max_adv_period_end_day_descr STRING(16777216),
cnt_periods_of_adv_week_overlap INTEGER DEFAULT 0 OPTIONS(description='Counting NUMBER of Overlapping Periods '),
sum_of_promotion_days_overlapping_in_adv_week INTEGER DEFAULT 0
OPTIONS(description='Counting distinct NUMBER of Overlapping days '),
cnt_periods_of_adv_week INTEGER DEFAULT 0,
sum_of_promotion_days_in_adv_week INTEGER DEFAULT - 1,
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, adv_week_id, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Dimension table for Adv.-Week');