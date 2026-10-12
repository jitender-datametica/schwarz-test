/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_WAREHOUSE
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_DIM_WAREHOUSE
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli  Initial version
#  2.1	2022-07-18 Andreas Kurz		Reworked structure
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/
/*
VC: 
WAREHOUSE_MSTR_SID
WAREHOUSE_MSTR_GID
ORIG_WH_NR_NAME
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_WAREHOUSE');

DESC TABLE P_LEW_MART_PIT.T_DIM_WAREHOUSE;

DROP VIEW P_LEW_MART_PIT.V_DIM_WAREHOUSE

*/



CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_WAREHOUSE
COMMENT = 'Source View Dimension Warehouse - Level'
AS
SELECT
	  CLIENT_ID
	, COUNTRY_ISO_CD
	, COUNTRY_DESCR
	, WAREHOUSE_SID
	, IFF(WAREHOUSE_SID < 0
			, (WAREHOUSE_SID * 100::INTEGER) - CLIENT_ID
			, (WAREHOUSE_SID * 100::INTEGER) + CLIENT_ID
		) AS WAREHOUSE_MSTR_SID
	, WAREHOUSE_GID
	, IFF(WAREHOUSE_GID < 0
			, (WAREHOUSE_GID * 100::INTEGER) - CLIENT_ID
			, (WAREHOUSE_GID * 100::INTEGER) + CLIENT_ID
		) AS WAREHOUSE_MSTR_GID
	, WAREHOUSE_NAME
	, ORIG_WH_NR
	, IFF(WAREHOUSE_SID < 0
			, WAREHOUSE_NAME
			  || ' - ' 
			  || COUNTRY_DESCR
			, (TRIM(CAST(ORIG_WH_NR AS VARCHAR))) 
			  || ' - ' 
			  || WAREHOUSE_NAME
		) AS ORIG_WH_NR_NAME
    , CASE  WHEN ORIG_WH_NR >= 0 THEN ORIG_WH_NR
            ELSE NULL
            END        AS ORIG_WH_NR_POSITIVE
	, REGION_TYPE_ID
	, REGION_TYPE_DESCR
	, VALID_FROM_DT
	, VALID_TO_DT
	, VERSION_NR
	, CURRENT_FG
	, SCD_KEY_MD
	, REJECT_FG
	, REJECT_REASON_ID
	, SOURCE_SYSTEM_ID
	, DELETED_FG
	, DWH_CREATED_TS
	, DWH_UPDATED_TS
	, LOAD_ID
FROM
	P_LEW_MART_PIT.T_DIM_WAREHOUSE
WHERE TRUE
	AND DELETED_FG 	= 0
	AND REJECT_FG	= 0 
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_WAREHOUSE WHERE CLIENT_ID = 1 AND WAREHOUSE_MSTR_GID > 0 LIMIT 10;