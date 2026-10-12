/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022/2023
#-------------------------------------------------------------------------------
# Interface : View for T_CNTL_FE_MSTR_REPORT_TOC
#-------------------------------------------------------------------------------
# Describtion: Create View for T_CNTL_FE_MSTR_REPORT_TOC
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
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_REPORT_TOC
COMMENT = 'Access View Kontroll Table of Content of Reports'
AS
SELECT
	  toc.REPORT_ID
	, toc.REPORT_SORT_VAL
	, toc.REPORT_NAME
	, toc.REPORT_GUID
	, toc.REPORT_ANNOTATION
	, toc.REPORT_VISIBLE_FG
	, toc.REPORT_TEASER_FG
	, toc.REPORT_TYPE_FG
	, toc.REPORT_PANEL_NAME
	, toc.REPORT_PANEL_PSKEY
	, toc.REPORT_PANEL_PKEY
FROM P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORT_TOC toc
	
WHERE TRUE 	
	AND toc.DELETED_FG 					= 0
	AND toc.CURRENT_FG 					= 1
	--AND nt.NOTIFICATION_ID				> 0
	AND CURRENT_DATE()					BETWEEN toc.VALID_FROM_DT AND toc.VALID_TO_DT
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_REPORT_TOC WHERE TRUE 
/* --- EOF - END OF FILE --- */


