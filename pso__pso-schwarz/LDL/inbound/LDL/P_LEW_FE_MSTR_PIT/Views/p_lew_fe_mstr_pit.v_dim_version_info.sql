/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for PIT_VERSION_INFO
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-04-21 Prasanna Ranjan	Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_FE_MSTR_PIT.T_DIM_VERSION_INFO');

DESC TABLE P_LEW_FE_MSTR_PIT.T_DIM_VERSION_INFO;
           

DROP VIEW P_LEW_FE_MSTR_PIT.V_DIM_VERSION_INFO

*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_PIT_VERSION_INFO
------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_DIM_VERSION_INFO
COMMENT = 'View table PIT Versioning History / Info'
AS
SELECT
	  inf.VERSION_DT
	, inf.MAJOR_NBR
	, inf.MINOR_NBR
	, inf.BUILD_NBR
	, inf.REVISION_NBR
	, inf.PIT_ENVIRONMENT_DESCR
	, IFF(inf.PIT_ENVIRONMENT_DESCR = 'TD', 'Teradata 16.20', 'Snowflake') AS PIT_ENVIRONMENT_LONG_DESCR
	, inf.VERSION_INFO_DESCR
	, (TRIM(TO_CHAR(inf.MAJOR_NBR, '09'))) 
			|| '.' 
			|| (TRIM(TO_CHAR(inf.MINOR_NBR, '09'))) 
			|| '.' 
			|| (TRIM(TO_CHAR(inf.BUILD_NBR, '09')))
			|| '.'
			|| (TRIM(TO_CHAR(inf.REVISION_NBR, '09'))) AS VERSION_NBR_DESCR
	, inf.VERSION_INFO_DESCR 
			|| ' [' 
			|| VERSION_NBR_DESCR 
			|| '] - ' 
			|| (TO_CHAR(inf.VERSION_DT, 'YYYY-MM-DD')) AS VERSION_INFO_LONG_DESCR
	, inf.FE_MSTR_RELEVANT_FG
	, inf.CURRENT_PIT_VERSION_FG
	, inf.CURRENT_PIT_VERION_FG
	, inf.VALID_FROM_DT
	, inf.VALID_TO_DT
	, inf.VERSION_NR
	, inf.CURRENT_FG
	, inf.REJECT_FG
	, inf.REJECT_REASON_ID
	, inf.SOURCE_SYSTEM_ID
	, inf.DELETED_FG
	, inf.DWH_CREATED_TS
	, inf.DWH_UPDATED_TS
	, inf.LOAD_ID
	
FROM
	P_LEW_FE_MSTR_PIT.T_DIM_VERSION_INFO inf
	
WHERE TRUE
	AND inf.DELETED_FG 				= 0 
	AND inf.REJECT_FG				= 0
	
	AND inf.CURRENT_FG 				= 1
	
	AND inf.FE_MSTR_RELEVANT_FG 	= 1
	AND inf.CURRENT_PIT_VERSION_FG 	= 1
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_PIT_VERSION_INFO LIMIT 10;