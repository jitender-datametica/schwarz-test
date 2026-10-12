/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_PERIOD
#-------------------------------------------------------------------------------
# Description: Create View for Calendar Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz	    Initial version
#  1.1 	2022-03-21 Andreas Kurz		Added furtehr columns to view
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2  2022-08-23 Andreas Kurz		Added AND PROCESSED_ADV_PERIOD_FG = 1
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
ADV_PERIOD_MSTR_ID
ADV_PERIOD_DAYS_ID
ADV_WEEK_WEEK_NR
ADV_WEEK_YEAR_ID
ADV_WEEK_LDESCR
ADV_PERIOD_START_DT_DESCR
ADV_PERIOD_END_DT_DESCR
ADV_PERIOD_DESCR
ADV_PERIOD_SDESCR
ADV_PERIOD_LDESCR
ADV_PERIOD_XLDESCR
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_PERIOD');
DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_PERIOD

DROP VIEW P_LEW_MART_PIT.V_DIM_ADV_PERIOD

*/

/*
---------------------------------------------------------------------
0. Create View Table in V_DIM_ADV_PERIOD
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_PERIOD
COMMENT = 'View table Adv-Period (only valid records)'
AS 
SELECT
	  CLIENT_ID
	, COUNTRY_ISO_CD
	, COUNTRY_DESCR
	, CTR_ADV_WEEK_START_WEEKDAY_ID
	, ADV_WEEK_ID
	, (ADV_WEEK_ID * 100) + CLIENT_ID					AS ADV_WEEK_MSTR_ID
	, ADV_WEEK_START_DT
	, ADV_WEEK_END_DT
	, ADV_PERIOD_START_DT
	, ADV_PERIOD_END_DT
	, EXTRACT(dayofweek_iso FROM ADV_PERIOD_START_DT) 	AS ADV_PERIOD_START_DAY_ID
	, EXTRACT(dayofweek_iso FROM ADV_PERIOD_END_DT) 	AS ADV_PERIOD_END_DAY_ID
	, ADV_PERIOD_LENGTH_IN_DAYS
	, ADV_PERIOD_START_DAY_SDESCR
	, ADV_PERIOD_END_DAY_SDESCR
	, ADV_PERIOD_START_DAY_DESCR
	, ADV_PERIOD_END_DAY_DESCR
	, OVERLAP_PERIOD_FG
	, OVERLAP_ADV_PERIOD_START_DT
	, OVERLAP_ADV_PERIOD_END_DT
	, DATEDIFF('day' 
				, OVERLAP_ADV_PERIOD_START_DT::DATE
				, OVERLAP_ADV_PERIOD_END_DT::DATE) AS OVERLAP_ADV_PERIOD_LENGTH_IN_DAYS
	, OVERLAP_ADV_WEEK_ID
	, CURRENT_ADV_PERIOD_FG
	, ADV_PERIOD_ID
	, TO_CHAR(
			(ADV_PERIOD_ID * 100) + CLIENT_ID 
			)												 AS ADV_PERIOD_MSTR_ID
    , (ADV_PERIOD_START_DAY_ID * 10) + ADV_PERIOD_END_DAY_ID AS ADV_PERIOD_DAYS_ID
	, PROCESSED_ADV_PERIOD_FG
	, MOV_ADV_PERIOD_START_FROM_CURRENT
	, MOV_ADV_PERIOD_ID_FROM_START_NR
	, REJECT_FG
	, REJECT_REASON_ID
	, SOURCE_SYSTEM_ID
	, DELETED_FG
	, DWH_CREATED_TS
	, DWH_UPDATED_TS
	, LOAD_ID
	, (ADV_WEEK_ID % 100) AS ADV_WEEK_WEEK_NR
	, TRY_CAST(SUBSTRING(CAST(ADV_WEEK_ID AS VARCHAR)
				        , 1
				        , 4
				        ) 
			   AS INTEGER) AS ADV_WEEK_YEAR_ID
	, TRIM( (TO_CHAR(ADV_WEEK_WEEK_NR, '09')) 
			|| '/' 
			|| (CAST(ADV_WEEK_YEAR_ID AS VARCHAR))
		   ) AS ADV_WEEK_LDESCR
	, TRIM(TO_CHAR(ADV_PERIOD_START_DT, 'DD.MM.YYYY')) AS ADV_PERIOD_START_DT_DESCR
	, TRIM(TO_CHAR(ADV_PERIOD_END_DT, 'DD.MM.YYYY')) AS ADV_PERIOD_END_DT_DESCR
	, TRIM(ADV_WEEK_LDESCR 
			|| ': ' 
			|| ADV_PERIOD_START_DAY_SDESCR 
			|| '-' 
			|| ADV_PERIOD_END_DAY_SDESCR) AS ADV_PERIOD_DESCR
	, TRIM(ADV_PERIOD_START_DAY_SDESCR
			|| '-'
			|| ADV_PERIOD_END_DAY_SDESCR) AS ADV_PERIOD_SDESCR
	, TRIM(ADV_PERIOD_START_DAY_SDESCR
			|| ' ' 
			|| ADV_PERIOD_START_DT_DESCR
			|| ' bis '
			|| ADV_PERIOD_END_DAY_SDESCR
			|| ' '
			|| ADV_PERIOD_END_DT_DESCR) AS ADV_PERIOD_LDESCR
	, TRIM('Periode: von: ' 
			|| ADV_PERIOD_START_DAY_DESCR
			|| ' ' 
			|| ADV_PERIOD_START_DT_DESCR 
			|| ' bis: ' 
			|| ADV_PERIOD_END_DAY_DESCR 
			|| ' ' 
			|| ADV_PERIOD_END_DT_DESCR 
			|| ' in Werbewoche: ' 
			|| ADV_WEEK_LDESCR) AS ADV_PERIOD_XLDESCR
	, ADV_WEEK_PERIOD_SORT_VAL
FROM
	P_LEW_MART_PIT.T_DIM_ADV_PERIOD
WHERE TRUE
	AND DELETED_FG 				= 0
	AND REJECT_FG				= 0
	--AND PROCESSED_ADV_PERIOD_FG = 1
;

-- DESC VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_PERIOD
-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_PERIOD WHERE CLIENT_ID IN (1) AND ADV_WEEK_ID = 202409 LIMIT 10;