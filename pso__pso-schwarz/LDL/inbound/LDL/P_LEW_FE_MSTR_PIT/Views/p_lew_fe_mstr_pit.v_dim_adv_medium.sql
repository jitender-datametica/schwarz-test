/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW for DIM_ADV_MEDIUM
#-------------------------------------------------------------------------------
# Description: Create DDL for view V_DIM_ADV_MEDIUM
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Mike Davis    	Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
MEDIUM_NAME_UPPER
MEDIUM_MSTR_SID
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_MART_PIT; 


SELECT '>>> ${EXEC_PIT_TIMESTAMP}  Creating View [V_CNTL_ETL_PERFORMANCE] ' AS ""
;

SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_MEDIUM');

DROP VIEW P_LEW_MART_PIT.V_DIM_ADV_MEDIUM

*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_MEDIUM
COMMENT = 'View on Advertising Medium (only valid records)'
AS
	SELECT 
		  CLIENT_ID 
		, COUNTRY_ISO_CD 
		, COUNTRY_DESCR 
		, MEDIUM_NAME 
		, UPPER(MEDIUM_NAME) AS MEDIUM_NAME_UPPER 
		, MEDIUM_NAME_LDESCR 
		, MEDIUM_SID 
		, IFF(MEDIUM_SID < 0
              ,(MEDIUM_SID * 100) - CLIENT_ID
              ,(MEDIUM_SID * 100) + CLIENT_ID
              ) AS MEDIUM_MSTR_SID
		, MEDIUM_SORT_VAL
		, MISSING_MEDIUM_FG
		, VALID_FROM_DT
		, VALID_TO_DT
		, VERSION_NR
		, CURRENT_FG
		, REJECT_FG 
		, REJECT_REASON_ID 
		, SOURCE_SYSTEM_ID 
		, DELETED_FG 
		, DWH_CREATED_TS 
		, DWH_UPDATED_TS 
		, LOAD_ID 
	FROM   P_LEW_MART_PIT.T_DIM_ADV_MEDIUM
	WHERE  TRUE
		AND REJECT_FG     = 0
        AND DELETED_FG    = 0
;
-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_MEDIUM LIMIT 10;