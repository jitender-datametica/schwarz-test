/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_WEEK
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_2 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz	    Initial version
#  1.1 	2022-03-21 Andreas Kurz		Added furtehr columns to view
#  1.2 	2022-03-21 Dirk Hering		Restricted on closed, processed adv weeks
#  2.0	2022-07-16 Nikolai Toknov   Changing the script for DevOps
#  2.1 	2022-07-18 Dirk Hering		View changed to P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED_2
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1  2025-09-16 Andreas Kurz		Adding Cube Loading FG and Cube Start/End Adv Weeks
#  4.2  2025-11-19 Nikolai Toknov	Fix prod issue. NEOPIT-250 [ISSUE] Falling load process if parameters are created for the future.
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE DATABASE LDL_QUALITY_CLONE_PIT_PROD;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
*/

/*
---------------------------------------------------------------------
0. Create View Table in V_DIM_ADV_WEEK_PROCESSED_2
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PROCESSED_2
COMMENT = 'View only on processed, closed Advertising Weeks'
AS 
SELECT 
      advw.CLIENT_ID
    , advw.COUNTRY_ISO_CD
    , advw.COUNTRY_DESCR
    , advw.CTR_ADV_WEEK_START_WEEKDAY_ID
    , advw.ADV_WEEK_ID
    , advw.ADV_WEEK_MSTR_ID
	
	, advw.START_ADV_WEEK_MSTR_ID_CUBE_LOAD
	, advw.END_ADV_WEEK_MSTR_ID_CUBE_LOAD
	, advw.CUBE_LOAD_FG
	
    , advw.ADV_WEEK_YEAR_ID
    , advw.ADV_WEEK_START_DT
    , advw.ADV_WEEK_END_DT
    , advw.ADV_WEEK_START_DT_DESCR
    , advw.ADV_WEEK_END_DT_DESCR
    , advw.LENGTH_OF_ADV_WEEK
    , advw.ADV_WEEK_START_DAY_SDESCR
    , advw.ADV_WEEK_END_DAY_SDESCR
    , advw.ADV_WEEK_START_DAY_DESCR
    , advw.ADV_WEEK_END_DAY_DESCR
    , advw.ADV_WEEK_WEEK_NR
    , advw.ADV_WEEK_DESCR
    , advw.ADV_WEEK_LDESCR
    , advw.ADV_WEEK_SDESCR
    , advw.PREV_1_ADV_WEEK_ID
    , advw.PREV_2_ADV_WEEK_ID
    , advw.PREV_3_ADV_WEEK_ID
    , advw.PREV_4_ADV_WEEK_ID
    , advw.PREV_5_ADV_WEEK_ID
    , advw.PREV_6_ADV_WEEK_ID
    , advw.PREV_7_ADV_WEEK_ID
    , advw.PREV_8_ADV_WEEK_ID
    , advw.PREV_9_ADV_WEEK_ID
    , advw.NEXT_1_ADV_WEEK_ID
    , advw.PREV_1_YEAR_ADV_WEEK_ID
    , advw.PROCESSED_ADV_WEEK_FG
    , advw.LAST_CLOSED_ADV_WEEK_ID
    , advw.LAST_ADV_WEEK_ID
    , advw.LAST_ADV_WEEK_FG
    , advw.LAST_CLOSED_ADV_WEEK_FG
    , advw.MOV_ADV_WEEK_START_FROM_CURRENT
    , advw.MOV_ADV_WEEK_ID_FROM_START_NR
    , advw.MAX_ADV_PERIOD_END_DT
    , advw.MAX_ADV_PERIOD_END_DAY_SDESCR
    , advw.MAX_ADV_PERIOD_END_DAY_DESCR
    , advw.ADV_WEEK_OVERLAP_LDESCR
	, advw.CNT_PERIODS_OF_ADV_WEEK_OVERLAP
	, advw.SUM_OF_PROMOTION_DAYS_OVERLAPPING_IN_ADV_WEEK
	, advw.CNT_PERIODS_OF_ADV_WEEK
	, advw.SUM_OF_PROMOTION_DAYS_IN_ADV_WEEK
    , advw.REJECT_FG
    , advw.REJECT_REASON_ID
    , advw.SOURCE_SYSTEM_ID
    , advw.DELETED_FG
    , advw.DWH_CREATED_TS
    , advw.DWH_UPDATED_TS
    , advw.LOAD_ID
    
FROM 

(
	SELECT
		  CLIENT_ID
		, COUNTRY_ISO_CD
		, COUNTRY_DESCR
		, CTR_ADV_WEEK_START_WEEKDAY_ID
		, ADV_WEEK_ID
		, ADV_WEEK_MSTR_ID
		
		, START_ADV_WEEK_MSTR_ID_CUBE_LOAD
		, END_ADV_WEEK_MSTR_ID_CUBE_LOAD
		, CUBE_LOAD_FG
	
		, ADV_WEEK_YEAR_ID
		, ADV_WEEK_START_DT
		, ADV_WEEK_END_DT
		, ADV_WEEK_START_DT_DESCR
		, ADV_WEEK_END_DT_DESCR
		, LENGTH_OF_ADV_WEEK
		, ADV_WEEK_START_DAY_SDESCR
		, ADV_WEEK_END_DAY_SDESCR
		, ADV_WEEK_START_DAY_DESCR
		, ADV_WEEK_END_DAY_DESCR
		, ADV_WEEK_WEEK_NR
		, ADV_WEEK_DESCR
		, ADV_WEEK_LDESCR
		, ADV_WEEK_SDESCR
		, PREV_1_ADV_WEEK_ID
		, PREV_2_ADV_WEEK_ID
		, PREV_3_ADV_WEEK_ID
		, PREV_4_ADV_WEEK_ID
		, PREV_5_ADV_WEEK_ID
		, PREV_6_ADV_WEEK_ID
		, PREV_7_ADV_WEEK_ID
		, PREV_8_ADV_WEEK_ID
		, PREV_9_ADV_WEEK_ID
		, NEXT_1_ADV_WEEK_ID
		, PREV_1_YEAR_ADV_WEEK_ID
		, PROCESSED_ADV_WEEK_FG
		, LAST_CLOSED_ADV_WEEK_ID
		, LAST_ADV_WEEK_ID
		, LAST_ADV_WEEK_FG
		, LAST_CLOSED_ADV_WEEK_FG
		, MOV_ADV_WEEK_START_FROM_CURRENT
		, MOV_ADV_WEEK_ID_FROM_START_NR
		, MAX_ADV_PERIOD_END_DT
		, MAX_ADV_PERIOD_END_DAY_SDESCR
		, MAX_ADV_PERIOD_END_DAY_DESCR
		, ADV_WEEK_OVERLAP_LDESCR
		, CNT_PERIODS_OF_ADV_WEEK_OVERLAP
		, SUM_OF_PROMOTION_DAYS_OVERLAPPING_IN_ADV_WEEK
		, CNT_PERIODS_OF_ADV_WEEK
		, SUM_OF_PROMOTION_DAYS_IN_ADV_WEEK
		, REJECT_FG
		, REJECT_REASON_ID
		, SOURCE_SYSTEM_ID
		, DELETED_FG
		, DWH_CREATED_TS
		, DWH_UPDATED_TS
		, LOAD_ID	
	FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2 advw
	WHERE TRUE
		-- only regard processed adv weeks
		AND PROCESSED_ADV_WEEK_FG   = 1
		AND DELETED_FG              = 0
		AND REJECT_FG               = 0 
	QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID , ADV_WEEK_ID ORDER BY DWH_CREATED_TS DESC) = 1 		
) advw

-- retrieve last Closed Week Id per Client
-- v4.2 fix prod issue NEOPIT-250  [ISSUE] Falling load process if parameters are created for the future.
/*
INNER JOIN
(
    SELECT  
          CLIENT_ID
        , LAST_CLOSED_ADV_WEEK_ID
    FROM  P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2
    WHERE TRUE
        AND LAST_CLOSED_ADV_WEEK_FG = 1
        AND DELETED_FG              = 0
        AND REJECT_FG               = 0
    QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID ORDER BY LAST_CLOSED_ADV_WEEK_ID DESC, DWH_CREATED_TS DESC) = 1
) ladvw
ON TRUE
    AND advw.CLIENT_ID     =   ladvw.CLIENT_ID
    AND advw.ADV_WEEK_ID   <=  ladvw.LAST_CLOSED_ADV_WEEK_ID
*/
WHERE TRUE
;