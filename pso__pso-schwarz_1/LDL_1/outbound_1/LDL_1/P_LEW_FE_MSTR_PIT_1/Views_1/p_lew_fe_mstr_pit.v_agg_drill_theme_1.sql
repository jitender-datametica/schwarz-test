/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for AGG_DRILL_THEME
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for AGG_DRILL_THEME
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  1.1  2023-01-30 Andreas Kurz		Added Action Type ID
#  1.2  2023-06-29 K Lukaszewska	Testing cube information added
#  1.3  2023-07-12 Prasanna Ranjan  Removed CUBE_PARTITION_KEY
#  3.0	2023-06-26 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz)
#  3.1  2023-07-28 Nikolai Toknov	Rollback WA
#  3.2  2023-09-13 K Lukaszewska	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Adding THEME_GRP_CAT Columns
#  4.0 2024-06-19 K Lukaszewska	Column DRILL_TO_ITEMS_LINK_HTML_FILIAL added
#  4.1  2025-02-10 Andreas Kurz		Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

-- LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT
--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_AGG_DRILL_THEME_1');
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_agg_drill_theme_1 
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_agg_drill_theme_1 (client_id, country_iso_cd, country_descr, warehouse_sid
, warehouse_mstr_sid, warehouse_name, orig_wh_nr, adv_week_id, adv_week_mstr_id, reporting_line_sid,
reporting_line_descr, theme_grp_type_id, theme_grp_type_sort_val, theme_grp_type_name, theme_grp_type_descr,
theme_grp_int_sid, theme_grp_int_mstr_sid, theme_grp_int_name, theme_grp_int_sort_val, theme_grp_nat_sid,
theme_grp_nat_mstr_sid, theme_grp_nat_name, theme_grp_nat_sort_val, theme_grp_nat_cat_sid, theme_grp_nat_cat_mstr_sid,
theme_grp_nat_cat_name, theme_grp_nat_cat_sort_val, theme_grp_main_mstr_sid, theme_grp_main_name,
drill_to_items_link_html, drill_to_hist_link_html, reject_fg, reject_reason_id, source_system_id, deleted_fg,
dwh_created_ts, dwh_updated_ts, load_id, warehouse_gid, warehouse_mstr_gid, action_type_id, theme_grp_name,
theme_grp_mstr_sid, theme_grp_sid) OPTIONS(DESCRIPTION = `VIEW DIMENSION AGG_DRILL_THEME`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 warehouse_sid,
 warehouse_mstr_sid,
 warehouse_name,
 orig_wh_nr,
 adv_week_id,
 adv_week_mstr_id,
 reporting_line_sid,
 reporting_line_descr,
 theme_grp_type_id,
 theme_grp_type_sort_val,
 theme_grp_type_name,
 theme_grp_type_descr,
 theme_grp_int_sid,
 theme_grp_int_mstr_sid,
 theme_grp_int_name,
 CAST(NULL AS BIGNUMERIC) AS theme_grp_int_sort_val,
 theme_grp_nat_sid,
 theme_grp_nat_mstr_sid,
 theme_grp_nat_name,
 CAST(NULL AS BIGNUMERIC) AS theme_grp_nat_sort_val,
 theme_grp_nat_cat_sid,
 theme_grp_nat_cat_mstr_sid,
 theme_grp_nat_cat_name,
 CAST(NULL AS BIGNUMERIC) AS theme_grp_nat_cat_sort_val,
 theme_grp_main_mstr_sid,
 theme_grp_main_name,
 drill_to_items_link_html,
 drill_to_hist_link_html,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id,
 warehouse_gid,
 warehouse_mstr_gid,
 action_type_id,
 CAST(NULL AS STRING) AS theme_grp_name,
 CAST(NULL AS BIGNUMERIC) AS theme_grp_mstr_sid,
 CAST(NULL AS BIGNUMERIC) AS theme_grp_sid
FROM ldl_p_lew_fe_mstr_pit.t_agg_drill_theme_1 AS AGG
WHERE deleted_fg = 0
 AND reject_fg = 0;