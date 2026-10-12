/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for AGG_DRILL_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for AGG_DRILL_ITEM
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  1.1  2023-06-29 K Lukaszewska	Testing cube information added
#  1.2  2023-07-12 Prasanna Ranjan  Removed CUBE_PARTITION_KEY
#  1.6  2025-02-10 Andreas Kurz		Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

-- LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT
--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_AGG_DRILL_ITEM_1');
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_agg_drill_item_1 
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_agg_drill_item_1 OPTIONS(DESCRIPTION = `VIEW DIMENSION AGG_DRILL_ITEM`) AS
SELECT client_id,
 country_iso_cd,
 country_descr,
 warehouse_sid,
 warehouse_mstr_sid,
 warehouse_name,
 orig_wh_nr,
 adv_week_id,
 adv_week_mstr_id,
 orig_item_nr,
 orig_item_mstr_nr,
 item_int_descr,
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
 orig_item_gid,
 orig_item_mstr_gid
FROM ldl_p_lew_fe_mstr_pit.t_agg_drill_item_1 AS AGG
WHERE deleted_fg = 0
 AND reject_fg = 0;