/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW for V_DIM_ADV_THEME_GRP_NAT_CAT_1
#-------------------------------------------------------------------------------
# Description: Create DDL for view V_DIM_ADV_THEME_GRP_NAT_CAT_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-09-12  K Lukaszewska 	Changes INT/NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INT / NAT aus APT
#									Initial Version 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
THEME_GRP_NAT_CAT_MSTR_SID
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_NAT_CAT_1');

DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_THEME_GRP_NAT_CAT_1;

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_ADV_THEME_GRP_NAT_CAT_1

*/


/*
---------------------------------------------------------------------
0. Create DIM View in V_DIM_ADV_THEME_GRP_NAT_CAT_1
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_theme_grp_nat_cat_1 (client_id, country_iso_cd, country_descr,
theme_grp_nat_cat_sid, theme_grp_nat_cat_mstr_sid, theme_grp_nat_cat_name, theme_grp_nat_cat_name_upper,
theme_grp_nat_cat_sort_val, valid_from_dt, valid_to_dt, version_nr, current_fg, reject_fg, reject_reason_id,
source_system_id, deleted_fg, dwh_created_ts, dwh_updated_ts, load_id)
OPTIONS(DESCRIPTION = `AS-IS VIEW ON T_DIM_ADV_THEME_GRP_NAT_CAT_1`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 theme_grp_nat_cat_sid,
 IF(theme_grp_nat_cat_sid < 0, theme_grp_nat_cat_sid * 100 - client_id, theme_grp_nat_cat_sid * 100 + client_id) AS
 theme_grp_nat_cat_mstr_sid,
 theme_grp_nat_cat_name,
 theme_grp_nat_cat_name_upper,
 theme_grp_nat_cat_sort_val,
 PARSE_DATE('%F', '1900-01-01') AS valid_from_dt,
 PARSE_DATE('%F', '9999-12-31') AS valid_to_dt,
 0 AS version_nr,
 1 AS current_fg,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_dim_adv_theme_grp_nat_cat_1
WHERE reject_fg = 0
 AND deleted_fg = 0;