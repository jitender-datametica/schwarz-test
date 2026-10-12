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


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_cntl_fe_mstr_report_toc
OPTIONS(DESCRIPTION = `ACCESS VIEW KONTROLL TABLE OF CONTENT OF REPORTS`) AS SELECT report_id,
 report_sort_val,
 report_name,
 report_guid,
 report_annotation,
 report_visible_fg,
 report_teaser_fg,
 report_type_fg,
 report_panel_name,
 report_panel_pskey,
 report_panel_pkey
FROM ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_report_toc AS TOC
WHERE deleted_fg = 0
 AND current_fg = 1
 AND CURRENT_DATE BETWEEN valid_from_dt AND valid_to_dt;