/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_ITEM_FAMILY_GRP
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_DIM_ITEM_FAMILY_GRP
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
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ITEM_FAMILY_GRP
COMMENT = 'Source View Dimension ITEM Family Group'
AS 
SELECT
	  CLIENT_ID
	, COUNTRY_ISO_CD
	, COUNTRY_DESCR
	, ITEM_FAM_GRP_SID

	, IFF(ITEM_FAM_GRP_SID < 0
			,(ITEM_FAM_GRP_SID * 100) - CLIENT_ID
			,(ITEM_FAM_GRP_SID * 100) + CLIENT_ID
		) AS ITEM_FAM_GRP_MSTR_SID
		
	, ITEM_FAM_GRP_GID
	
	, IFF(ITEM_FAM_GRP_GID < 0							
			, (ITEM_FAM_GRP_GID * 100::INTEGER) - CLIENT_ID							
			, (ITEM_FAM_GRP_GID * 100::INTEGER) + CLIENT_ID							
		) AS ITEM_FAM_GRP_MSTR_GID
		
	, ITEM_FAM_GRP_SRC_ID
	, ITEM_FAM_GRP_SRC_CD
	, ITEM_FAM_GRP_NAME
	, ITEM_FAM_GRP_DESCR
	, ITEM_FAM_GRP_INT_DESCR
	
	, SUB_ITEM_GRP_SID	
	
	, IFF(SUB_ITEM_GRP_SID < 0
			,(SUB_ITEM_GRP_SID * 100) - CLIENT_ID
			,(SUB_ITEM_GRP_SID * 100) + CLIENT_ID
		) AS SUB_ITEM_GRP_MSTR_SID
				
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
	P_LEW_MART_PIT.T_DIM_ITEM_FAMILY_GRP
WHERE TRUE
	AND DELETED_FG 	= 0
	AND REJECT_FG 	= 0	
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ITEM_FAMILY_GRP LIMIT 10;