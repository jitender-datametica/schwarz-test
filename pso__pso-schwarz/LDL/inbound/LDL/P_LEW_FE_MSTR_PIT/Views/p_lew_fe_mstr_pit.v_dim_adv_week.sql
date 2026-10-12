/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_WEEK
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-12-20 Andreas Kurz	    Initial version
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
ADV_WEEK_START_DT_DESCR;
ADV_WEEK_END_DT_DESCR;
LENGTH_OF_ADV_WEEK;
*/
/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK
COMMENT = 'View Control Adv.-Week'
AS
SELECT
	  adw.CLIENT_ID										
	, adw.COUNTRY_ISO_CD									
	, adw.COUNTRY_DESCR									
	, adw.CTR_ADV_WEEK_START_WEEKDAY_ID					
	, adw.ADV_WEEK_ID										
	, (adw.ADV_WEEK_ID * 100) + adw.CLIENT_ID 	AS ADV_WEEK_MSTR_ID	
	
	, pa.START_ADV_WEEK_MSTR_ID_CUBE_LOAD
	, pa.END_ADV_WEEK_MSTR_ID_CUBE_LOAD
	
	, iff(ADV_WEEK_MSTR_ID BETWEEN pa.START_ADV_WEEK_MSTR_ID_CUBE_LOAD AND pa.END_ADV_WEEK_MSTR_ID_CUBE_LOAD
		,1
		,0)::SMALLINT 							AS CUBE_LOAD_FG 
	, TRY_CAST(SUBSTRING(CAST(adw.ADV_WEEK_ID AS VARCHAR)
						, 1
						, 4
						) 
				AS INTEGER) AS ADV_WEEK_YEAR_ID								
	, adw.ADV_WEEK_START_DT								
	, adw.ADV_WEEK_END_DT									
	, TO_CHAR(adw.ADV_WEEK_START_DT, 'DD.MM.YYYY') AS ADV_WEEK_START_DT_DESCR							
	, TO_CHAR(adw.ADV_WEEK_END_DT, 'DD.MM.YYYY')  AS ADV_WEEK_END_DT_DESCR							
	, (CAST( DATE_DIFFDATEINDAYS(ADV_WEEK_START_DT
			,ADV_WEEK_END_DT)
			AS NUMBER(9,0))
			) + 1 AS LENGTH_OF_ADV_WEEK								
	, adw.ADV_WEEK_START_DAY_SDESCR						
	, adw.ADV_WEEK_END_DAY_SDESCR							
	, adw.ADV_WEEK_START_DAY_DESCR						
	, adw.ADV_WEEK_END_DAY_DESCR							
	, (adw.ADV_WEEK_ID % 100) AS ADV_WEEK_WEEK_NR								
	, TRIM(
			(TO_CHAR(ADV_WEEK_WEEK_NR, '09')) 
			|| '/' 
			|| (CAST(ADV_WEEK_YEAR_ID AS VARCHAR))
			) AS ADV_WEEK_DESCR									
	, TRIM(
			'Werbewoche: ' 
			|| ADV_WEEK_DESCR 
			|| ' von: ' 
			|| ADV_WEEK_START_DT_DESCR 
			|| ' bis: ' 
			|| ADV_WEEK_END_DT_DESCR
			) AS ADV_WEEK_LDESCR									
	, TRIM(
			(TO_CHAR(ADV_WEEK_WEEK_NR, '09')) 
			|| '/' 
			|| (CAST(ADV_WEEK_YEAR_ID % 100 AS VARCHAR))
			) AS ADV_WEEK_SDESCR									
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
	, TRIM(
			ADV_WEEK_START_DAY_SDESCR 
			|| ' ' 
			|| ADV_WEEK_START_DT_DESCR 
			|| ' bis ' 
			|| ADV_WEEK_END_DAY_SDESCR 
			|| ' ' 
			|| ADV_WEEK_END_DT_DESCR 
			|| ' (Maximale Laufzeit bis ' 
			|| MAX_ADV_PERIOD_END_DAY_SDESCR 
			|| ' ' 
			|| (TO_CHAR(MAX_ADV_PERIOD_END_DT, 'DD.MM.YYYY')) 
			|| ')'
			) AS ADV_WEEK_OVERLAP_LDESCR							
	, adw.CNT_PERIODS_OF_ADV_WEEK_OVERLAP					
	, adw.SUM_OF_PROMOTION_DAYS_OVERLAPPING_IN_ADV_WEEK	
	, adw.CNT_PERIODS_OF_ADV_WEEK							
	, adw.SUM_OF_PROMOTION_DAYS_IN_ADV_WEEK				
	, adw.REJECT_FG										
	, adw.REJECT_REASON_ID								
	, adw.SOURCE_SYSTEM_ID								
	, adw.DELETED_FG										
	, adw.DWH_CREATED_TS									
	, adw.DWH_UPDATED_TS									
	, adw.LOAD_ID		 					
FROM P_LEW_MART_PIT.T_DIM_ADV_WEEK adw

-- Cube Loading
INNER JOIN 
(
 SELECT 
 	* 
 FROM P_LEW_FE_MSTR_PIT.V_CNTL_PROCESSING_PARAM_NORMALIZED 
 WHERE TRUE 
 	--AND CLIENT_ID = 1
) pa 
ON TRUE 
	AND pa.CLIENT_ID 	= adw.CLIENT_ID
	
WHERE TRUE
	AND adw.DELETED_FG 	= 0
	AND adw.REJECT_FG	= 0
;	

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK LIMIT 1;


/* --- EOF - END OF FILE --- */

									