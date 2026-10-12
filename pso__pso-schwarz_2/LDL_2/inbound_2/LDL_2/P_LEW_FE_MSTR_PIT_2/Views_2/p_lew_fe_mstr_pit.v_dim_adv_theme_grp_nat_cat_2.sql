/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW for V_DIM_ADV_THEME_GRP_NAT_CAT_2
#-------------------------------------------------------------------------------
# Description: Create DDL for view V_DIM_ADV_THEME_GRP_NAT_CAT_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-09-12  K Lukaszewska 	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Initial Version 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
THEME_GRP_NAT_CAT_MSTR_SID
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_NAT_CAT_2');

DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_NAT_CAT_2;

DROP VIEW P_LEW_MART_PIT.V_DIM_ADV_THEME_GRP_NAT_CAT_2

*/


/*
---------------------------------------------------------------------
0. Create DIM View in V_DIM_ADV_THEME_GRP_NAT_CAT_2
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP_NAT_CAT_2
COMMENT = 'As-Is View on T_DIM_ADV_THEME_GRP_NAT_CAT_2'
(
		  CLIENT_ID
		, COUNTRY_ISO_CD
		, COUNTRY_DESCR
		, THEME_GRP_NAT_CAT_SID
		, THEME_GRP_NAT_CAT_MSTR_SID
		, THEME_GRP_NAT_CAT_NAME
		, THEME_GRP_NAT_CAT_NAME_UPPER
		, THEME_GRP_NAT_CAT_SORT_VAL
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
		, THEME_GRP_NAT_CAT_SID
		, IFF(THEME_GRP_NAT_CAT_SID < 0,
			    (THEME_GRP_NAT_CAT_SID * 100) - CLIENT_ID,
				(THEME_GRP_NAT_CAT_SID * 100) + CLIENT_ID
			   ) AS THEME_GRP_NAT_CAT_MSTR_SID
		, THEME_GRP_NAT_CAT_NAME
		, THEME_GRP_NAT_CAT_NAME_UPPER
		, THEME_GRP_NAT_CAT_SORT_VAL
		, TO_DATE('1900-01-01','YYYY-MM_2-DD') VALID_FROM_DT
		, TO_DATE('9999-12-31','YYYY-MM_2-DD') VALID_TO_DT
		, 0::SMALLINT VERSION_NR
		, 1::SMALLINT CURRENT_FG
		, REJECT_FG
		, REJECT_REASON_ID
		, SOURCE_SYSTEM_ID
		, DELETED_FG
		, DWH_CREATED_TS
		, DWH_UPDATED_TS
		, LOAD_ID
	FROM P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_NAT_CAT_2
	WHERE TRUE
		AND REJECT_FG     = 0
		AND DELETED_FG    = 0
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP_NAT_CAT_2 WHERE CLIENT_ID = 32 AND THEME_GRP_NAT_CAT_SID = 300000037932 < 0 LIMIT 10;