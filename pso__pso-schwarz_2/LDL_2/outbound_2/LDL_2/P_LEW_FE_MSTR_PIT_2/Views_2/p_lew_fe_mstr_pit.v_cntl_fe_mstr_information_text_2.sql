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


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_cntl_fe_mstr_information_text_2
OPTIONS(DESCRIPTION = `ACCESS VIEW FOR CONTROL TABLE - FRONTEND INFORMATION FOR THE STARTPAGE AND REPORT PAGES`) AS
SELECT information_id,
 information_html_descr_de,
 information_html_descr_en,
 information_author,
 information_entry_dt,
 information_visible_start_page_fg,
 information_visible_report_fg,
 valid_from_dt,
 valid_to_dt,
 version_nr,
 current_fg,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_information_text_2 AS INF
WHERE deleted_fg = 0
 AND current_fg = 1;