/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW for DIM_ADV_MEDIUM_GRP
#-------------------------------------------------------------------------------
# Description: Create DDL for view V_DIM_ADV_MEDIUM_GRP_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Mike Davis    Initial version
#  2.0	2022-07-16 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
MEDIUM_GRP_MSTR_SID
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_GRP_2');
DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_MEDIUM_GRP_2

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_ADV_MEDIUM_GRP_2

*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_medium_grp_2 (client_id, country_iso_cd, country_descr,
medium_grp_name, medium_grp_sid, medium_grp_mstr_sid, medium_grp_sort_val, medium_grp_ignore_fg,
medium_grp_always_vis_fg, valid_from_dt, valid_to_dt, version_nr, current_fg, reject_fg, reject_reason_id,
source_system_id, deleted_fg, dwh_created_ts, dwh_updated_ts, load_id)
OPTIONS(DESCRIPTION = `VIEW ON MEDIUM GROUP (ONLY VALID RECORDS)`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 medium_grp_name,
 medium_grp_sid,
 IF(medium_grp_sid < 0, medium_grp_sid * 100 - client_id, medium_grp_sid * 100 + client_id) AS medium_grp_mstr_sid,
 medium_grp_sort_val,
 medium_grp_ignore_fg,
 medium_grp_always_vis_fg,
 valid_from_dt,
 valid_to_dt,
 version_nr,
 current_fg,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_dim_adv_medium_grp_2
WHERE reject_fg = 0
 AND deleted_fg = 0;