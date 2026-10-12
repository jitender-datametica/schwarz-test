/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2024
#-------------------------------------------------------------------------------
# Interface : View for V_CNTL_ETL_LOGGING_1
#-------------------------------------------------------------------------------
# Describtion: Create View for V_CNTL_ETL_LOGGING_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2024-04-18 Nikolai Toknov	    Initial version. Task DDLvsGIT. Created the file based on the object in PROD.
#  1.1	2025-01-08 Andreas Kurz			Reworked based on R60001
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_CNTL_ETL_LOGGING_1
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_CNTL_ETL_LOGGING_1(
	RUN_ID_SEQ,
	RUN_TS_CHAR,
	RUN_DAY_ID_CHAR,
	RUN_TS,
	RUN_DAY_ID,
	RUN_CLUSTERING_DESC,
	CLIENT_ID,
	MULTI_CLIENT_RUN_LST,
	MULTI_CLIENT_RUN_LST_NR,
	MULTI_CLIENT_RUN_LST_DESCR,
	MULTI_CLIENT_RUN_FG,
	APPLICATION_NAME,
	MODULE_NAME,
	COMPONENT_NAME,
	START_RUN_TS,
	END_RUN_TS,
	RUN_TIME_MIN,
	RUN_TIME_SEC,
	QUERY_TAG,
	SF_USER,
	SF_WAREHOUSE,
	SF_ROLE,
	SF_DATABASE,
	SF_SCHEMA,
	SF_SESSION,
	SF_CLIENT,
	RECORD_PROCESSED_NR,
	START_PROCESSING_FG,
	END_PROCESSING_FG,
	MODULE_LEVEL_FG,
	COMPONENT_LEVEL_FG,
	COMPLETED_RUN_FG,
	DELETED_FG,
	DWH_CREATED_TS,
	DWH_UPDATED_TS,
	LOAD_ID,
	MOVING_RUN_ID_FROM_CURRENT
) COMMENT='Access View Kontroll ETL Logging'
 AS
SELECT
	  lg.RUN_ID_SEQ 
	, TO_CHAR(lg.RUN_TS, 'YYYY-MM_1-DD HH24:MI:SS.FF3')	AS RUN_TS_CHAR
	, TO_CHAR(lg.RUN_DAY_ID, 'YYYY-MM_1-DD')				AS RUN_DAY_ID_CHAR	  
	, lg.RUN_TS
	, lg.RUN_DAY_ID
	, lg.RUN_CLUSTERING_DESC
	, lg.CLIENT_ID
	, lg.MULTI_CLIENT_RUN_LST				
	, ARRAY_SIZE(lg.MULTI_CLIENT_RUN_LST)::INTEGER AS MULTI_CLIENT_RUN_LST_NR								
	, ARRAY_TO_STRING(lg.MULTI_CLIENT_RUN_LST, ',') AS MULTI_CLIENT_RUN_LST_DESCR
	, IFF(MULTI_CLIENT_RUN_LST_NR > 1
		,1
		,0)::SMALLINT AS MULTI_CLIENT_RUN_FG
	, lg.APPLICATION_NAME
	, lg.MODULE_NAME
	, lg.COMPONENT_NAME
	, TO_CHAR(lg.START_RUN_TS, 'YYYY-MM_1-DD HH24:MI:SS') AS START_RUN_TS
	, TO_CHAR(lg.END_RUN_TS, 'YYYY-MM_1-DD HH24:MI:SS') 	AS END_RUN_TS
	, TIMEDIFF('min',START_RUN_TS,END_RUN_TS) AS RUN_TIME_MIN
	, TIMEDIFF('sec',START_RUN_TS,END_RUN_TS) AS RUN_TIME_SEC
	, lg.QUERY_TAG
	, lg.SF_USER
	, lg.SF_WAREHOUSE
	, lg.SF_ROLE
	, lg.SF_DATABASE
	, lg.SF_SCHEMA
	, lg.SF_SESSION
	, lg.SF_CLIENT
	--, lg.RUN_LDESC
	, lg.RECORD_PROCESSED_NR
	, lg.START_PROCESSING_FG
	, lg.END_PROCESSING_FG
	, lg.MODULE_LEVEL_FG
	, lg.COMPONENT_LEVEL_FG
	, lg.COMPLETED_RUN_FG
	-- technical fields
	, lg.DELETED_FG			
	, lg.DWH_CREATED_TS		
	, lg.DWH_UPDATED_TS		
	, lg.LOAD_ID	
	, (DENSE_RANK () OVER (ORDER BY lg.RUN_ID_SEQ DESC) -1 ) * (-1) MOVING_RUN_ID_FROM_CURRENT
FROM P_LEW_MART_PIT.T_CNTL_ETL_LOGGING_1 lg
WHERE TRUE 	
	AND lg.DELETED_FG 	= 0
;	
