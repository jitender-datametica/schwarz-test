/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_PERIOD, joined with DIM_ADV_WEEK
#-------------------------------------------------------------------------------
# Description: Combining info fields of adv period with additional adv week fields.
#              This is just to provide an interface for the MSTR schema (migrated from PITonPrem to PITonCloud):
#              The MSTR attribute "Werbeperiode Start Ende Datum" uses period and adv week fields.
#              Later this attribute could be replaced in all reports by the 2 attributes Werbeperiode, Werbewoche.
#              Especially the info window in all Documents would need to be adjusted to show the "Maximale Laufzeit ..."
#              from the Werbewoche attribute.
#              Then, this view will be obsolete.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-06-02 Dirk Hering      Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PERIOD_2');

DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_PERIOD_2;
DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_WEEK_2;
           

DROP VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PERIOD_2

*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PERIOD_2
COMMENT = 'View Adv-Period with added Adv-Week fields'
AS
SELECT
	  adp.CLIENT_ID
	, adp.COUNTRY_ISO_CD
	, adp.COUNTRY_DESCR
	, adp.CTR_ADV_WEEK_START_WEEKDAY_ID
	
	, adp.ADV_PERIOD_START_DT
	, adp.ADV_PERIOD_END_DT
	, adp.ADV_PERIOD_START_DAY_ID
	, adp.ADV_PERIOD_END_DAY_ID
	, adp.ADV_PERIOD_LENGTH_IN_DAYS
	, adp.ADV_PERIOD_START_DAY_SDESCR
	, adp.ADV_PERIOD_END_DAY_SDESCR
	, adp.ADV_PERIOD_START_DAY_DESCR
	, adp.ADV_PERIOD_END_DAY_DESCR
	, adp.OVERLAP_PERIOD_FG
	, adp.OVERLAP_ADV_PERIOD_START_DT
	, adp.OVERLAP_ADV_PERIOD_END_DT
	, adp.OVERLAP_ADV_PERIOD_LENGTH_IN_DAYS
	, adp.OVERLAP_ADV_WEEK_ID
	, adp.CURRENT_ADV_PERIOD_FG
	, adp.ADV_PERIOD_ID
	, adp.ADV_PERIOD_MSTR_ID
	, adp.PROCESSED_ADV_PERIOD_FG
	, adp.MOV_ADV_PERIOD_START_FROM_CURRENT
	, adp.MOV_ADV_PERIOD_ID_FROM_START_NR

	, adp.ADV_PERIOD_START_DT_DESCR
	, adp.ADV_PERIOD_END_DT_DESCR
	, adp.ADV_PERIOD_DESCR
	, adp.ADV_PERIOD_SDESCR
	, adp.ADV_PERIOD_LDESCR
	, adp.ADV_PERIOD_XLDESCR
	, adp.ADV_WEEK_PERIOD_SORT_VAL
  
	-- Adv Week
	, adw.ADV_WEEK_ID
	, adw.ADV_WEEK_MSTR_ID
	, adw.ADV_WEEK_YEAR_ID
	, adw.ADV_WEEK_START_DT
	, adw.ADV_WEEK_END_DT
	, adw.ADV_WEEK_START_DT_DESCR
	, adw.ADV_WEEK_END_DT_DESCR
	, adw.LENGTH_OF_ADV_WEEK
	, adw.ADV_WEEK_START_DAY_SDESCR
	, adw.ADV_WEEK_END_DAY_SDESCR
	, adw.ADV_WEEK_START_DAY_DESCR
	, adw.ADV_WEEK_END_DAY_DESCR
	, adw.ADV_WEEK_WEEK_NR
	, adw.PREV_1_ADV_WEEK_ID
	, adw.PREV_2_ADV_WEEK_ID
	, adw.PREV_3_ADV_WEEK_ID
	, adw.PREV_4_ADV_WEEK_ID
	, adw.PREV_5_ADV_WEEK_ID
	, adw.PREV_6_ADV_WEEK_ID
	, adw.PREV_7_ADV_WEEK_ID
	, adw.PREV_8_ADV_WEEK_ID
	, adw.PREV_9_ADV_WEEK_ID
	, adw.NEXT_1_ADV_WEEK_ID
	, adw.PREV_1_YEAR_ADV_WEEK_ID
	, adw.PROCESSED_ADV_WEEK_FG
	, adw.LAST_CLOSED_ADV_WEEK_ID
	, adw.LAST_ADV_WEEK_ID
	, adw.LAST_ADV_WEEK_FG
	, adw.LAST_CLOSED_ADV_WEEK_FG
	, adw.MOV_ADV_WEEK_START_FROM_CURRENT
	, adw.MOV_ADV_WEEK_ID_FROM_START_NR
	, adw.MAX_ADV_PERIOD_END_DT
	, adw.MAX_ADV_PERIOD_END_DAY_SDESCR
	, adw.MAX_ADV_PERIOD_END_DAY_DESCR
	, adw.CNT_PERIODS_OF_ADV_WEEK_OVERLAP
	, adw.SUM_OF_PROMOTION_DAYS_OVERLAPPING_IN_ADV_WEEK
	, adw.CNT_PERIODS_OF_ADV_WEEK
	, adw.SUM_OF_PROMOTION_DAYS_IN_ADV_WEEK
	, adw.ADV_WEEK_DESCR
	, adw.ADV_WEEK_LDESCR
	, adw.ADV_WEEK_SDESCR
	, adw.ADV_WEEK_OVERLAP_LDESCR	
FROM
	(
		SELECT
			  CLIENT_ID
			, COUNTRY_ISO_CD
			, COUNTRY_DESCR
			, CTR_ADV_WEEK_START_WEEKDAY_ID
			, ADV_WEEK_ID
			, ADV_WEEK_MSTR_ID
			, ADV_WEEK_START_DT
			, ADV_WEEK_END_DT
			, ADV_PERIOD_START_DT
			, ADV_PERIOD_END_DT
			, ADV_PERIOD_START_DAY_ID
			, ADV_PERIOD_END_DAY_ID
			, ADV_PERIOD_LENGTH_IN_DAYS
			, ADV_PERIOD_START_DAY_SDESCR
			, ADV_PERIOD_END_DAY_SDESCR
			, ADV_PERIOD_START_DAY_DESCR
			, ADV_PERIOD_END_DAY_DESCR
			, OVERLAP_PERIOD_FG
			, OVERLAP_ADV_PERIOD_START_DT
			, OVERLAP_ADV_PERIOD_END_DT
			, OVERLAP_ADV_PERIOD_LENGTH_IN_DAYS
			, OVERLAP_ADV_WEEK_ID
			, CURRENT_ADV_PERIOD_FG
			, ADV_PERIOD_ID
			, ADV_PERIOD_MSTR_ID
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
			, ADV_WEEK_WEEK_NR
			, ADV_WEEK_YEAR_ID
			, ADV_WEEK_LDESCR
			, ADV_PERIOD_START_DT_DESCR
			, ADV_PERIOD_END_DT_DESCR
			, ADV_PERIOD_DESCR
			, ADV_PERIOD_SDESCR
			, ADV_PERIOD_LDESCR
			, ADV_PERIOD_XLDESCR
			, ADV_WEEK_PERIOD_SORT_VAL		
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_PERIOD_2 
		WHERE TRUE
			AND DELETED_FG    = 0
			AND REJECT_FG     = 0				
	) adp
	
	-- Adv Week
	INNER JOIN  
	(
		SELECT
			  CLIENT_ID
			, COUNTRY_ISO_CD
			, COUNTRY_DESCR
			, CTR_ADV_WEEK_START_WEEKDAY_ID
			, ADV_WEEK_ID
			, ADV_WEEK_MSTR_ID
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
			, ADV_WEEK_DESCR
			, ADV_WEEK_LDESCR
			, ADV_WEEK_SDESCR
			, ADV_WEEK_OVERLAP_LDESCR
		FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2 
		WHERE TRUE
			AND DELETED_FG    = 0
			AND REJECT_FG     = 0		
	)
	adw
    ON TRUE
		AND adp.CLIENT_ID     = adw.CLIENT_ID
		AND adp.ADV_WEEK_ID   = adw.ADV_WEEK_ID
    
WHERE TRUE
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PERIOD_2 LIMIT 10;