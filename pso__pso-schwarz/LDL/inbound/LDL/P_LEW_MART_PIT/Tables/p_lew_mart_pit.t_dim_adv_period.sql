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
ALTER TABLE P_LEW_MART_PIT.T_DIM_ADV_PERIOD RENAME COLUMN ADV_LENGTH_OF_PERIOD to ADV_PERIOD_LENGTH_IN_DAYS;

UPDATE P_LEW_MART_PIT.T_DIM_ADV_PERIOD 
SET ADV_PERIOD_LENGTH_IN_DAYS = datediff('days',ADV_PERIOD_START_DT, ADV_PERIOD_END_DT)+1
*/

CREATE TABLE P_LEW_MART_PIT.T_DIM_ADV_PERIOD CLUSTER BY (CLIENT_ID) (
	CLIENT_ID							INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Client ID e.g. 1=>AT',
	COUNTRY_ISO_CD						VARCHAR(3) 																COMMENT 'Country ISO Code = WAWI Country ',
	COUNTRY_DESCR						VARCHAR 																COMMENT 'Country Name',

	-- AKU 2022-01-18 Should be kept but is part of the params, best to load via join	
	-- based on ISO mon ::= 1	
	CTR_ADV_WEEK_START_WEEKDAY_ID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Start Day Id of the Adv-Week per Country. E.g. CH=4; based on ISO Kaleneder Mon::=1,..,Sun::=7',


	ADV_WEEK_ID							INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Foreign key Adv.Week ID, every Adv.Period has an Adv.Week',

	ADV_WEEK_START_DT					DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Start DATE of Adv-Week',
	ADV_WEEK_END_DT						DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'End DATE of Adv.-Week',

	ADV_PERIOD_START_DT					DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD')	COMMENT 'Start DATE of the Adv.Period',
	ADV_PERIOD_END_DT					DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD')	COMMENT 'End DATE of the Adv.Period',
	ADV_PERIOD_LENGTH_IN_DAYS			NUMBER(38,0)															COMMENT 'Length Advertisement Period in Days',
	
	-- Mo.	
	ADV_PERIOD_START_DAY_SDESCR			VARCHAR 																COMMENT 'German short description of the week day, when this period starts. E.g.: Mo.',
	
	-- Fr.								
	ADV_PERIOD_END_DAY_SDESCR			VARCHAR 																COMMENT 'German short description of the week day, when this period end. E.g.: Fr.',
	
	-- Montag								
	ADV_PERIOD_START_DAY_DESCR			VARCHAR 																COMMENT 'German long description of the week day, when this period starts. E.g.: Montag (Monday).',
	
	-- Freitag								
	ADV_PERIOD_END_DAY_DESCR			VARCHAR 																COMMENT 'German long description of the week day, when this period end. E.g.: Freitag (Freitag).',
	OVERLAP_PERIOD_FG					SMALLINT					DEFAULT 0 									COMMENT 'Flag Indicates is True (1) if period extend into next calendar week',
	OVERLAP_ADV_PERIOD_START_DT			DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'Start DATE of the overlapping  Adv.Period. [Start_dt – OVERlap_end Dt] [OVERlap_start_dt – end_dt]',
	OVERLAP_ADV_PERIOD_END_DT			DATE			NOT NULL	DEFAULT TO_DATE('8888-12-31', 'YYYY-MM-DD') COMMENT 'End DATE of the overlapping Adv.Period',

	OVERLAP_ADV_WEEK_ID					INTEGER		 															COMMENT 'Adv. Week ID of overlapping Periods. ',
	
	CURRENT_ADV_PERIOD_FG				SMALLINT					DEFAULT 0 									COMMENT 'Flag / Indicator current Adv.Period = 1. Based on CURENT_DATE Only formally required.',
	
	-- 20220313  --> Adv.Week 2022/03 and Adv.Period From Monday to Wednesday 
	-- or Function: f_GetAdvPeriodId 
	ADV_PERIOD_ID						INTEGER			NOT NULL	DEFAULT -1 									COMMENT '[VC] Unique identifier of Adv. Period. ((ADV_WEEK_ID * 100) + ((ADV_PERIOD_START_DAY_ID * 10) + ADV_PERIOD_END_DAY_ID))',
    -- PROCESSED_ADV_PERIOD_ID_FG 1::=ADV.-Period was processed; 0::=artifical generated
	PROCESSED_ADV_PERIOD_FG				SMALLINT					DEFAULT 0 									COMMENT 'Indicator if the Adv.-Period is processed by PIT. 1::=ADV_WEEK Was processed; 0::=artifical generated. Adv-Week Data based on Calendar Data.',
	MOV_ADV_PERIOD_START_FROM_CURRENT	INTEGER						DEFAULT -1 									COMMENT 'Current Adv.-Period is ::0 , pervious Adv.-Period is -1 Next Adv.-Period is +1',
	MOV_ADV_PERIOD_ID_FROM_START_NR		INTEGER						DEFAULT -1 									COMMENT 'Calculated RowNumber Adv.-Period from Start. First Row is marked with 0',
    
	-- Period sort value 
	ADV_WEEK_PERIOD_SORT_VAL			INTEGER						DEFAULT 88885399							COMMENT 'Sort Order for Display in Frontend MSTR',
	
	-- Technical Fields
	REJECT_FG							SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
	REJECT_REASON_ID					INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Link to DQ Reject Reason Codes',
	SOURCE_SYSTEM_ID					INTEGER			NOT NULL	DEFAULT -1 									COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
	DELETED_FG							SMALLINT		NOT NULL	DEFAULT 0 									COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
	DWH_CREATED_TS						TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP() 				COMMENT 'Timestamp when record was created',
	DWH_UPDATED_TS						TIMESTAMP		 														COMMENT 'Technical field timestamp when record was updated',
	LOAD_ID								INTEGER			NOT NULL	DEFAULT 0 									COMMENT 'Technical Field ELT / ABInitio Process ID',
	PRIMARY KEY (CLIENT_ID, ADV_PERIOD_ID, DELETED_FG)
)	COMMENT='Dimension table for Adv.-Period'
;
