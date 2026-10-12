/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW for DIM_ADV_THEME_GRP_NAT
#-------------------------------------------------------------------------------
# Description: Create DDL for view V_DIM_ADV_THEME_GRP_NAT_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Mike Davis    	Initial version
#  1.1  2022-06-22 Andreas Kurz	 	Reworked Structure
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2	2022-08-11 Nikolai Toknov	Change for Theme 
#  2.3	2023-02-02 Nikolai Toknov	Fix issue from last commit.
#  3.0	2023-06-22 Nikolai Toknov	Add view for AP0100400_THEMA_NAT/INT
#  3.1  2023-07-28 Nikolai Toknov	Rollback WA
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
THEME_GRP_NAT_MSTR_SID
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_NAT_1');

DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_NAT_1;

DROP VIEW P_LEW_MART_PIT.V_DIM_ADV_THEME_GRP_NAT_1

*/


/*
---------------------------------------------------------------------
0. Create DIM View in V_DIM_ADV_THEME_GRP_NAT_1
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP_NAT_1
COMMENT = 'As-Is View on T_DIM_ADV_THEME_GRP_NAT_1'
(
		  CLIENT_ID
		, COUNTRY_ISO_CD
		, COUNTRY_DESCR
		, THEME_GRP_NAT_SID
		, THEME_GRP_NAT_MSTR_SID
		, THEME_GRP_NAT_NAME
		, THEME_GRP_NAT_NAME_UPPER
		, THEME_GRP_NAT_SORT_VAL
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
		-- TRY_TO_NUMBER(LEFT(TO_CHAR(THEME_GRP_NAT_SID),2) || RIGHT(TO_CHAR(THEME_GRP_NAT_SID),10)) AS _THEME_GRP_NAT_SID
		, THEME_GRP_NAT_SID
		-- _THEME_GRP_NAT_SID * 100::INTEGER + CLIENT_ID AS THEME_GRP_NAT_MSTR_SID
		, IFF(THEME_GRP_NAT_SID < 0,
                (THEME_GRP_NAT_SID * 100) - CLIENT_ID,
			    (THEME_GRP_NAT_SID * 100) + CLIENT_ID
			) AS THEME_GRP_NAT_MSTR_SID
		, THEME_GRP_NAT_NAME
		, THEME_GRP_NAT_NAME_UPPER
		, THEME_GRP_NAT_SORT_VAL
		, TO_DATE('1900-01-01','YYYY-MM_1-DD') VALID_FROM_DT
		, TO_DATE('9999-12-31','YYYY-MM_1-DD') VALID_TO_DT
		, 0::SMALLINT VERSION_NR
		, 1::SMALLINT CURRENT_FG
		, REJECT_FG
		, REJECT_REASON_ID
		, SOURCE_SYSTEM_ID
		, DELETED_FG
		, DWH_CREATED_TS
		, DWH_UPDATED_TS
		, LOAD_ID
	FROM P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_NAT_1
	WHERE TRUE
		AND REJECT_FG     = 0
		AND DELETED_FG    = 0
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP_NAT_1 LIMIT 10;