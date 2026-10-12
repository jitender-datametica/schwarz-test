/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022/2023
#-------------------------------------------------------------------------------
# Interface : View for T_CNTL_FE_MSTR_REPORTING_LINES_1
#-------------------------------------------------------------------------------
# Describtion: Create View for T_CNTL_FE_MSTR_REPORTING_LINES_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2025-02-05 Andreas Kurz	    Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 
*/

/* 
---------------------------------------------------------------------
0. Create View Table in V_ETL_LOGGING
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_REPORTING_LINES_1
COMMENT = 'Access View Kontroll Reporting Lines'
AS
SELECT
	 rpl.REPORTING_LINE_ID
	,rpl.REPORTING_LINE_DESCR
	,rpl.REPORTING_TYPE_ID
	,rpl.REPORTING_TYPE_DESCR
	,rpl.FE_MSTR_RELEVANT_FG
	,rpl.REPORTING_LINE_SID 
FROM P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORTING_LINES_1 rpl
	
WHERE TRUE 	
	AND rpl.DELETED_FG 					= 0
	AND rpl.REJECT_FG 					= 0
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_REPORTING_LINES_1 WHERE TRUE 
/* --- EOF - END OF FILE --- */


