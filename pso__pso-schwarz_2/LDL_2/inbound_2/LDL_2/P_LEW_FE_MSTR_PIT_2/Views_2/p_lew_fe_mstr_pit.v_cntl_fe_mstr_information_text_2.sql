/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for T_CNTL_FE_MSTR_INFORMATION_TEXT_2
#-------------------------------------------------------------------------------
# Description: Create View for Frontend Information for the Startpage and Report Pages
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-12-07 K Lukaszewska    Initial version 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 
*/ 

/*
---------------------------------------------------------------------
0. Create View for T_CNTL_FE_MSTR_INFORMATION_TEXT_2
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_INFORMATION_TEXT_2 
COMMENT = 'Access View for Control Table - Frontend Information for the Startpage and Report Pages'
AS
SELECT

	  inf.INFORMATION_ID
	, inf.INFORMATION_HTML_DESCR_DE
	, inf.INFORMATION_HTML_DESCR_EN
	
	, inf.INFORMATION_AUTHOR
	, inf.INFORMATION_ENTRY_DT

	, inf.INFORMATION_VISIBLE_START_PAGE_FG
	, inf.INFORMATION_VISIBLE_REPORT_FG
	
	, inf.VALID_FROM_DT
	, inf.VALID_TO_DT
	, inf.VERSION_NR
	, inf.CURRENT_FG
	
	, inf.SOURCE_SYSTEM_ID 
	, inf.DELETED_FG 
	, inf.DWH_CREATED_TS 	
	, inf.DWH_UPDATED_TS 	
	, inf.LOAD_ID
	
FROM P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_INFORMATION_TEXT_2 inf
WHERE TRUE
	AND inf.DELETED_FG 	= 0
	AND inf.CURRENT_FG	= 1
;

-- SELECT * FROM P_LEW_FE_MSTR_PIT.V_CNTL_FE_MSTR_INFORMATION_TEXT_2
/* --- EOF - END OF FILE --- */