/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_SUB_ITEM_GRP_1
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_DIM_SUB_ITEM_GRP_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Massimo Morelli  Initial version
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
SUB_ITEM_GRP_MSTR_SID
SUB_ITEM_GRP_MSTR_GID
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_SUB_ITEM_GRP_1');

DESC TABLE P_LEW_MART_PIT.T_DIM_SUB_ITEM_GRP_1;

DROP VIEW P_LEW_MART_PIT.V_DIM_SUB_ITEM_GRP_1

*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_SUB_ITEM_GRP_1
COMMENT = 'Source View Dimension UWG (Unterwarengruppe) - Sub Item_1 Group'
AS 
SELECT
	  CLIENT_ID
	, COUNTRY_ISO_CD
	, COUNTRY_DESCR
	, SUB_ITEM_GRP_SID
	, IFF(SUB_ITEM_GRP_SID < 0
			,(SUB_ITEM_GRP_SID * 100) - CLIENT_ID
			,(SUB_ITEM_GRP_SID * 100) + CLIENT_ID
		) AS SUB_ITEM_GRP_MSTR_SID
	, SUB_ITEM_GRP_GID
	, IFF(SUB_ITEM_GRP_GID < 0							
			, (SUB_ITEM_GRP_GID * 100::INTEGER) - CLIENT_ID							
			, (SUB_ITEM_GRP_GID * 100::INTEGER) + CLIENT_ID							
		) AS SUB_ITEM_GRP_MSTR_GID
	, SUB_ITEM_GRP_NAME
	, SUB_ITEM_GRP_SRC_CD
	, SUB_ITEM_GRP_DESCR
	, SUB_ITEM_GRP_INT_DESCR
	, ITEM_GRP_INT_SID
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
	P_LEW_MART_PIT.T_DIM_SUB_ITEM_GRP_1
WHERE TRUE
	AND DELETED_FG 	= 0
	AND REJECT_FG 	= 0	
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_SUB_ITEM_GRP_1 LIMIT 10;