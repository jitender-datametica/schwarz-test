/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW for DIM_ADV_MEDIUM_GRP
#-------------------------------------------------------------------------------
# Description: Create DDL for view V_DIM_ADV_MEDIUM_GRP
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Mike Davis    Initial version
#  2.0	2022-07-16 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
MEDIUM_GRP_MSTR_SID
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_GRP');
DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_GRP

DROP VIEW P_LEW_MART_PIT.V_DIM_ADV_MEDIUM_GRP

*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_MEDIUM_GRP
COMMENT = 'View on Medium Group (only valid records)'
(
	  CLIENT_ID
	, COUNTRY_ISO_CD
	, COUNTRY_DESCR
	, MEDIUM_GRP_NAME
	, MEDIUM_GRP_SID
	, MEDIUM_GRP_MSTR_SID
	, MEDIUM_GRP_SORT_VAL
	, MEDIUM_GRP_IGNORE_FG
	, MEDIUM_GRP_ALWAYS_VIS_FG
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
)
AS
   SELECT 
		  CLIENT_ID
		, COUNTRY_ISO_CD
		, COUNTRY_DESCR
		, MEDIUM_GRP_NAME
		, MEDIUM_GRP_SID
		, IFF(MEDIUM_GRP_SID < 0,
				(MEDIUM_GRP_SID * 100) - CLIENT_ID, 
				(MEDIUM_GRP_SID * 100) + CLIENT_ID
			  ) AS MEDIUM_GRP_MSTR_SID
		, MEDIUM_GRP_SORT_VAL
		, MEDIUM_GRP_IGNORE_FG
		, MEDIUM_GRP_ALWAYS_VIS_FG
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
   FROM   P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_GRP
   WHERE  TRUE
           AND REJECT_FG     = 0
           AND DELETED_FG    = 0

;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_MEDIUM_GRP LIMIT 10;