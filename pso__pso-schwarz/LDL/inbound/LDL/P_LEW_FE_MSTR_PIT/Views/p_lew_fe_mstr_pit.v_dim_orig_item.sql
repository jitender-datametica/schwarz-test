/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_ORIG_ITEM
#-------------------------------------------------------------------------------
# Description: CREATE VIEW fOR V_DIM_ORIG_ITEM
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli  Initial version
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2  2023-07-07 Andreas Kurz		Extend Output on BRAND_NAME and BRAND_TYPE_CD
#  2.3	2023-11-02 Andreas Kurz		added COALESCE(BRAND_NAME,'n/A') AS BRAND_NAME
#  3.0  2024-02-14 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
ORIG_ITEM_MSTR_NR
ORIG_ITEM_MSTR_GID
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S; 
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT

SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ORIG_ITEM');

DESC TABLE P_LEW_MART_PIT.T_DIM_ORIG_ITEM;

DROP VIEW P_LEW_MART_PIT.V_DIM_ORIG_ITEM

*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ORIG_ITEM
COMMENT = 'Source View Dimension NAN - National Articel Number (Orig Item Number)'
AS
SELECT
	  CLIENT_ID
	, COUNTRY_ISO_CD
	, COUNTRY_DESCR
	, ORIG_ITEM_NR
	, IFF(ORIG_ITEM_NR < 0
			,(ORIG_ITEM_NR * 100) - CLIENT_ID
			,(ORIG_ITEM_NR * 100) + CLIENT_ID
		) AS ORIG_ITEM_MSTR_NR
	, ORIG_ITEM_GID
	, IFF(ORIG_ITEM_GID < 0
			, (ORIG_ITEM_GID * 100::INTEGER) - CLIENT_ID
			, (ORIG_ITEM_GID * 100::INTEGER) + CLIENT_ID
		 ) AS ORIG_ITEM_MSTR_GID
		 
	, DAT_VALID_FROM
	, ITEM_NAME
	, ITEM_DESCR
	, ITEM_INT_DESCR
	, ITEM_FAM_GRP_SID
	, SUB_ITEM_GRP_SID
	, ITEM_GRP_INT_SID
	, BRAND_TYPE_CD
	, BRAND_SID
	, COALESCE(BRAND_NAME,'n/A') AS BRAND_NAME
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
	P_LEW_MART_PIT.T_DIM_ORIG_ITEM
WHERE TRUE
	--AND DELETED_FG 	= 0     -- ignore the deleted_fg by convention
	AND REJECT_FG 	= 0
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ORIG_ITEM LIMIT 10;