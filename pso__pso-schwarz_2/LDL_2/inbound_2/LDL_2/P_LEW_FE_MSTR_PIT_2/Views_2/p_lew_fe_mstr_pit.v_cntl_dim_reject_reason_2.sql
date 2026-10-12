/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for CNTL_DIM_REJECT_REASON
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_2 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-12-20 Andreas Kurz	    Initial version
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_2
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_CNTL_DIM_REJECT_REASON_2
COMMENT = 'View Control Reject Reason Codes for DQ-Dashboard'
AS
SELECT
	  rej.REJECT_REASON_ID 			
	, rej.REJECT_REASON_DESCR 		
	, rej.VALID_FROM_DT 				
	, rej.VALID_TO_DT 				
	, rej.VERSION_NR 					
	, rej.CURRENT_FG 					
	, rej.SOURCE_SYSTEM_ID 			
	, rej.DELETED_FG 					
	, rej.DWH_CREATED_TS 				
	, rej.DWH_UPDATED_TS 				
	, rej.LOAD_ID 					
FROM P_LEW_MART_PIT.T_CNTL_DIM_REJECT_REASON_2 rej
WHERE TRUE
	AND rej.DELETED_FG 	= 0
	AND rej.CURRENT_FG	= 1
	
QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY REJECT_REASON_ID)
;	

--SELECT * FROM P_LEW_FE_MSTR_PIT.V_CNTL_DIM_REJECT_REASON_2 LIMIT 1;


/* --- EOF - END OF FILE --- */