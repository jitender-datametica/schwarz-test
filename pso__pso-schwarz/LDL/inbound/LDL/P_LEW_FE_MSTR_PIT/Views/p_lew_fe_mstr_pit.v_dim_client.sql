/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_CLIENT
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-12-20 Andreas Kurz	    Initial version
#  1.1	2023-02-21 Andreas Kurz		Added PIT_COUNTRY_FG = 1 filter
#  1.2	2024-01-04 Andreas Kurz		Added Language_ID column  
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
--USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_CLIENT
COMMENT = 'View on Client Table'
AS
SELECT DISTINCT
	  cl.CLIENT_ID 									
	, cl.COUNTRY_ISO_CD 								
	, cl.COUNTRY_DESCR 								
	, cl.COUNTRY_ORIG_DESCR 							
	, cl.COUNTRY_NAT_DESCR							
	, cl.COUNTRY_INT_DESCR							
	, cl.LANG_SID 
	, cl.CLIENT_ID					AS LANGUAGE_ID
	, cl.CURR_SID 									
	, cl.CURR_CD 									
	, cl.EXCHANGE_RATE_TO_EUR 						
	, cl.CTR_ADV_WEEK_START_WEEKDAY_ID
	, COALESCE(cal.DAY_OF_WEEK_LDESC,'n/A') AS  DAY_OF_WEEK_LDESC-- Wochentag Long Desc
	, cl.CTR_STORE_NBR								
	, cl.CTR_EX_ELVIS_COUNTRY_FG 					
	, cl.CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_FROM 	
	, cl.CTR_EX_ELVIS_COUNTRY_MIGRATION_DATE_TO 		
	, cl.PIT_COUNTRY_FG 								
	, cl.VALID_FROM_DT 								
	, cl.VALID_TO_DT 								
	, cl.VERSION_NR 									
	, cl.CURRENT_FG 									
	, cl.REJECT_FG 									
	, cl.REJECT_REASON_ID 							
	, cl.SOURCE_SYSTEM_ID 							
	, cl.DELETED_FG 									
	, cl.DWH_CREATED_TS 								
	, cl.DWH_UPDATED_TS 								
	, cl.LOAD_ID 					
FROM P_LEW_MART_PIT.T_DIM_CLIENT cl

INNER JOIN P_LEW_MART_PIT.T_DIM_CALENDAR cal
ON TRUE
	AND cl.CTR_ADV_WEEK_START_WEEKDAY_ID = cal.DAY_OF_WEEK_ID
WHERE TRUE
	AND cl.DELETED_FG 	= 0
	AND cl.REJECT_FG	= 0
	AND cl.CURRENT_FG	= 1
	-- AKU 21-02-2023
	AND PIT_COUNTRY_FG 	= 1
	
QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID)
;	

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_CLIENT WHERE TRUE AND CLIENT_ID = 1 LIMIT 100;


/* --- EOF - END OF FILE --- */

									