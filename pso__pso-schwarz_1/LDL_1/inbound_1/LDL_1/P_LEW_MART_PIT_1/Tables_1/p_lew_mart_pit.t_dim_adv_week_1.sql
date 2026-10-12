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
CREATE TABLE P_LEW_MART_PIT.T_DIM_ADV_WEEK_1 CLUSTER BY (CLIENT_ID)(
	CLIENT_ID										INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD									VARCHAR(3) 																COMMENT 'Country_1 ISO Code = WAWI Country_1 ',
	COUNTRY_DESCR									VARCHAR 																COMMENT 'Country_1 Name',
	
	-- AKU 2022-01-18 Should be kept but is part of the params, best to load via join	
	-- based on ISO mon ::= 1
	CTR_ADV_WEEK_START_WEEKDAY_ID					INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Start Day Id of the Adv-Week per Country. E.g. CH=4; based on ISO Kaleneder Mon::=1,..,Sun::=7',
	ADV_WEEK_ID										INTEGER			NOT NULL	DEFAULT 888853 								COMMENT 'Adv.Week ID e.g. 202137 for week 37 of 2021',

	ADV_WEEK_START_DT								DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') COMMENT 'Start DATE of Adv-Week',
	ADV_WEEK_END_DT									DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') COMMENT 'End DATE of Adv.-Week',
-- AKU 2022-03-25 Added based on Techn. Konzept
	-- Mo.	
	ADV_WEEK_START_DAY_SDESCR						VARCHAR 																COMMENT 'German short description of the week day, when this adv week starts. Mo. = Montag (Monday)',
	-- Mo.				
	ADV_WEEK_END_DAY_SDESCR							VARCHAR 																COMMENT 'German short description of the week day, when this adv week ends. Mo. = Montag (Monday)',
	-- Montag				
	ADV_WEEK_START_DAY_DESCR						VARCHAR 																COMMENT 'German long description of the week day, when this adv week starts. Montag (Monday)',
	ADV_WEEK_END_DAY_DESCR							VARCHAR 																COMMENT 'German long description of the week day, when this adv week ends. Montag (Monday)',
	PREV_1_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Previous 1 Adv.Week ID e.g. 202124 --> 202123',
	PREV_2_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Previous 2 Adv.Week ID e.g. 202124 --> 202122',
	PREV_3_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Previous 3 Adv.Week ID e.g. 202124 --> 202121',
	PREV_4_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Previous 4 Adv.Week ID e.g. 202124 --> 202120',
	PREV_5_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Previous 5 Adv.Week ID e.g. 202124 --> 202119',
	PREV_6_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Previous 6 Adv.Week ID e.g. 202124 --> 202118',
	PREV_7_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Previous 7 Adv.Week ID e.g. 202124 --> 202117',
	PREV_8_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Previous 8 Adv.Week ID e.g. 202124 --> 202116',
	PREV_9_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Previous 9 Adv.Week ID e.g. 202124 --> 202115',
	NEXT_1_ADV_WEEK_ID								INTEGER						DEFAULT 888853 								COMMENT 'Next 1 Adv.Week ID e.g. 202124 --> 202125',
	PREV_1_YEAR_ADV_WEEK_ID							INTEGER						DEFAULT 888853 								COMMENT 'Previous 1 Year Adv.Week ID e.g. 202124 --> 202024',
	-- PROCESSED_ADV_WEEK_ID_FG 1::=ADV_WEEK Was processed; 0::=artifical generated
	PROCESSED_ADV_WEEK_FG							SMALLINT					DEFAULT 0 									COMMENT 'Indicator if the Adv.-Week is processed by PIT. 1::=ADV_WEEK Was processed; 0::=artifical generated. Adv-Week Data based on Calendar_1 Data.',
	LAST_CLOSED_ADV_WEEK_ID							INTEGER			NOT NULL	DEFAULT 888853 								COMMENT 'Week Id of the last Closed Adv.-Week per PIT Country_1',
	LAST_ADV_WEEK_ID								INTEGER			NOT NULL	DEFAULT 888853 								COMMENT 'Week Id of the last processed Adv.-Week per PIT Country_1, which is not closed.',
	LAST_ADV_WEEK_FG								SMALLINT					DEFAULT 0 									COMMENT 'Indicator if the Adv.-Week is the last processed Adv.-Week per PIT Country. 1::=last Adv.-Weel. 0::=not last Adv.-Week.',
	LAST_CLOSED_ADV_WEEK_FG							SMALLINT					DEFAULT 0 									COMMENT 'Indicator if the Adv.-Week is the last closed Adv.-Week per PIT Country. 1::=last closed Adv.-Weel. 0::=not last closed Adv.-Week.',
	MOV_ADV_WEEK_START_FROM_CURRENT					INTEGER						DEFAULT -1 									COMMENT 'Current Adv.-Week is ::0 , pervious Adv.-Week is -1 Next Adv. Week is +1',
	MOV_ADV_WEEK_ID_FROM_START_NR					INTEGER						DEFAULT -1 									COMMENT 'Calculated RowNumber Adv.-Week from Start. First Row is marked with 0',
	MAX_ADV_PERIOD_END_DT							DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM_1-DD') COMMENT 'Maximum assigned Adv. Period End DATE, in case of OVERlapping period. Needed for Reporting Information Window.',
	MAX_ADV_PERIOD_END_DAY_SDESCR					VARCHAR 																COMMENT 'German short description of the week day, when the max. adv week period ends. Fr. = Freitag (Friday)',
	MAX_ADV_PERIOD_END_DAY_DESCR					VARCHAR,
	
	CNT_PERIODS_OF_ADV_WEEK_OVERLAP					INTEGER						DEFAULT 0 									COMMENT 'Counting NUMBER of Overlapping Periods ',
	SUM_OF_PROMOTION_DAYS_OVERLAPPING_IN_ADV_WEEK	INTEGER						DEFAULT 0 									COMMENT 'Counting distinct NUMBER of Overlapping days ',
	CNT_PERIODS_OF_ADV_WEEK							INTEGER						DEFAULT 0,
	SUM_OF_PROMOTION_DAYS_IN_ADV_WEEK				INTEGER						DEFAULT -1,
    -- Technical fields
	REJECT_FG										SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID								INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID								INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG										SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS									TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS									TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID											INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ADV_WEEK_ID, DELETED_FG)
)	COMMENT='Dimension table for Adv.-Week'
;