/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_PERIOD
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Adv.Period Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-21 Mike Davis      	Fixes, formatting, FK support (now removed)
#  1.2  2022-03-16 Andreas Kurz		Typo correction in 									COMMENT Section
#  1.3 	2022-03-25 Andreas Kurz		Added more description columns based on Techn. Konzept
#									Some changes on DESC Format
#  2.0	2022-07-13 Nikolai Toknov  	Changing the script for DevOps
#  2.1  2022-07-18 Andreas Kurz		Added column ADV_WEEK_PERIOD_SORT_VAL
#  2.2	2022-07-22 Nikolai Toknov  	Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2024-12-21 Andreas Kurz		Rename VC column T_DIM_ADV_PERIOD. ADV_PERIOD_LENGTH_IN_DAYS from
#									ADV_LENGTH_OF_PERIOD
#-------------------------------------------------------------------------------
*/
/*
VC:
ADV_WEEK_MSTR_ID
ADV_PERIOD_MSTR_ID
ADV_WEEK_WEEK_NR
ADV_WEEK_YEAR_ID
ADV_WEEK_LDESCR
ADV_PERIOD_START_DT_DESCR
ADV_PERIOD_END_DT_DESCR
ADV_PERIOD_DESCR
ADV_PERIOD_SDESCR
ADV_PERIOD_LDESCR
ADV_PERIOD_XLDESCR
ADV_PERIOD_DAYS_ID
ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ADV_PERIOD RENAME COLUMN ADV_LENGTH_OF_PERIOD to ADV_PERIOD_LENGTH_IN_DAYS;

UPDATE LDL.P_LEW_MART_PIT.T_DIM_ADV_PERIOD 
SET ADV_PERIOD_LENGTH_IN_DAYS = datediff('days',ADV_PERIOD_START_DT, ADV_PERIOD_END_DT)+1
*/


-- based on ISO mon ::= 1
 -- Freitag
 -- 20220313  --> Adv.Week 2022/03 and Adv.Period From Monday to Wednesday

-- Mo.
 -- or Function: f_GetAdvPeriodId
 -- Period sort value
 -- Technical Fields
 -- Montag

-- AKU 2022-01-18 Should be kept but is part of the params, best to load via join
 -- Fr.

-- PROCESSED_ADV_PERIOD_ID_FG 1::=ADV.-Period was processed; 0::=artifical generated
 CREATE TABLE IF NOT EXISTS
ldl_p_lew_mart_pit.t_dim_adv_period (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
ctr_adv_week_start_weekday_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Start Day Id of the Adv-Week per Country. E.g. CH=4; based on ISO Kaleneder Mon::=1,..,Sun::=7'),
adv_week_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Foreign key Adv.Week ID, every Adv.Period has an Adv.Week'),
adv_week_start_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Start DATE of Adv-Week'),
adv_week_end_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='End DATE of Adv.-Week'),
adv_period_start_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Start DATE of the Adv.Period'),
adv_period_end_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='End DATE of the Adv.Period'),
adv_period_length_in_days BIGNUMERIC(38,0) OPTIONS(description='Length Advertisement Period in Days'),
adv_period_start_day_sdescr STRING(16777216)
OPTIONS(description='German short description of the week day, when this period starts. E.g.: Mo.'),
adv_period_end_day_sdescr STRING(16777216)
OPTIONS(description='German short description of the week day, when this period end. E.g.: Fr.'),
adv_period_start_day_descr STRING(16777216)
OPTIONS(description='German long description of the week day, when this period starts. E.g.: Montag (Monday).'),
adv_period_end_day_descr STRING(16777216)
OPTIONS(description='German long description of the week day, when this period end. E.g.: Freitag (Freitag).'),
overlap_period_fg INTEGER DEFAULT 0
OPTIONS(description='Flag Indicates is True (1) if period extend into next calendar week'),
overlap_adv_period_start_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start DATE of the overlapping  Adv.Period. [Start_dt – OVERlap_end Dt] [OVERlap_start_dt – end_dt]'),
overlap_adv_period_end_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End DATE of the overlapping Adv.Period'),
overlap_adv_week_id INTEGER OPTIONS(description='Adv. Week ID of overlapping Periods. '),
current_adv_period_fg INTEGER DEFAULT 0
OPTIONS(description='Flag / Indicator current Adv.Period = 1. Based on CURENT_DATE Only formally required.'),
adv_period_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='[VC] Unique identifier of Adv. Period. ((ADV_WEEK_ID * 100) + ((ADV_PERIOD_START_DAY_ID * 10) + ADV_PERIOD_END_DAY_ID))'),
processed_adv_period_fg INTEGER DEFAULT 0
OPTIONS(description='Indicator if the Adv.-Period is processed by PIT. 1::=ADV_WEEK Was processed; 0::=artifical generated. Adv-Week Data based on Calendar Data.'),
mov_adv_period_start_from_current INTEGER DEFAULT - 1
OPTIONS(description='Current Adv.-Period is ::0 , pervious Adv.-Period is -1 Next Adv.-Period is +1'),
mov_adv_period_id_from_start_nr INTEGER DEFAULT - 1
OPTIONS(description='Calculated RowNumber Adv.-Period from Start. First Row is marked with 0'),
adv_week_period_sort_val INTEGER DEFAULT 88885399 OPTIONS(description='Sort Order for Display in Frontend MSTR'),
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
PRIMARY KEY (client_id, adv_period_id, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Dimension table for Adv.-Period');