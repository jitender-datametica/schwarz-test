/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW for DIM_ADV_THEME_GRP
#-------------------------------------------------------------------------------
# Description: Create DDL for view V_DIM_ADV_THEME_GRP
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
#  2.4  2023-07-28 Nikolai Toknov	Rollback WA
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP');

DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP;

DROP VIEW P_LEW_MART_PIT.V_DIM_ADV_THEME_GRP

*/


/*
---------------------------------------------------------------------
0. Create DIM View in V_DIM_ADV_THEME_MAIN_GRP_2
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_MAIN_GRP_2
COMMENT = 'As-Is View on T_DIM_ADV_THEME_MAIN_GRP'
(
	 CLIENT_ID
	,COUNTRY_ISO_CD
	,COUNTRY_DESCR
	,THEME_GRP_TYPE_ID
	,THEME_GRP_TYPE_NAME
	,THEME_GRP_MAIN_MSTR_SID
	,THEME_GRP_MAIN_NAME
	,THEME_GRP_MAIN_NAME_UPPER
	, VALID_FROM_DT
	, VALID_TO_DT
	, VERSION_NR
	, CURRENT_FG
)

AS
	SELECT 
		  agg.CLIENT_ID::INTEGER						AS CLIENT_ID
		, agg.COUNTRY_ISO_CD::VARCHAR(3)				AS COUNTRY_ISO_CD
		, agg.COUNTRY_DESCR::VARCHAR(50)				AS COUNTRY_DESCR

		, agg.THEME_GRP_TYPE_ID::INTEGER				AS THEME_GRP_TYPE_ID
		, agg.THEME_GRP_TYPE_NAME::VARCHAR(150)			AS THEME_GRP_TYPE_NAME

		-- TRY_TO_NUMBER( LEFT(TO_CHAR(agg.THEME_GRP_MAIN_MSTR_SID),2) || RIGHT(TO_CHAR(agg.THEME_GRP_MAIN_MSTR_SID),10) )::NUMBER(38,0) 
		, agg.THEME_GRP_MAIN_MSTR_SID												AS THEME_GRP_MAIN_MSTR_SID 
		, agg.THEME_GRP_MAIN_NAME::VARCHAR(150)			AS THEME_GRP_MAIN_NAME

	
		, UPPER(TRIM(agg.THEME_GRP_MAIN_NAME))			AS THEME_GRP_MAIN_NAME_UPPER

		, TO_DATE('1900-01-01','YYYY-MM_2-DD') 			AS VALID_FROM_DT
		, TO_DATE('9999-12-31','YYYY-MM_2-DD') 			AS VALID_TO_DT
		, 0::SMALLINT 									AS VERSION_NR
		, 1::SMALLINT 									AS CURRENT_FG
		
	FROM 
		(
			SELECT
				  CLIENT_ID
				, COUNTRY_ISO_CD
				, COUNTRY_DESCR	
				, THEME_GRP_TYPE_ID
				, THEME_GRP_TYPE_NAME
				, THEME_GRP_MAIN_MSTR_SID
				, THEME_GRP_MAIN_NAME				
			FROM 
				P_LEW_FE_MSTR_PIT.T_AGG_REGION_THEME_ALL_2 
			WHERE TRUE
				AND REJECT_FG     = 0
				AND DELETED_FG    = 0
				--AND THEME_GRP_MAIN_MSTR_SID < 0
			GROUP BY 1,2,3,4,5,6,7
		) agg
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_MAIN_GRP_2 LIMIT 10;
