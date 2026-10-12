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


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_cntl_fe_mstr_reporting_lines_1
OPTIONS(DESCRIPTION = `ACCESS VIEW KONTROLL REPORTING LINES`) AS SELECT reporting_line_id,
 reporting_line_descr,
 reporting_type_id,
 reporting_type_descr,
 fe_mstr_relevant_fg,
 reporting_line_sid
FROM ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_reporting_lines_1 AS RPL
WHERE deleted_fg = 0
 AND reject_fg = 0;