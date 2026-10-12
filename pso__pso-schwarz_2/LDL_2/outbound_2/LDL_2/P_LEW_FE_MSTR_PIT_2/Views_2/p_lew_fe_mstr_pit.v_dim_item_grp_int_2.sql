/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_ITEM_GRP_INT_2
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_DIM_ITEM_GRP_INT_2
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Massimo Morelli  Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2	2022-07-26 Dirk Hering		Filtered out WGI 0 (Artikel_2 pauschal), 00 (Administration), negative WGI codes (already filtered out in source view)
#  2.3	2022-08-05 Dirk Hering		Commented out filtering out WGI 0, 00 -> this is filtered out in load_t_p_f_store_day_adv_period_item.sql
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
ITEM_GRP_INT_MSTR_SID
ITEM_GRP_INT_MSTR_GID
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ITEM_GRP_INT_2');

DESC TABLE P_LEW_MART_PIT.T_DIM_ITEM_GRP_INT_2;

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_ITEM_GRP_INT_2

*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_item_grp_int_2
OPTIONS(DESCRIPTION = `SOURCE VIEW DIMENSION WGI (WARENGRUPPE INTERNATIONAL)`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 item_grp_int_sid,
 IF(item_grp_int_sid < 0, item_grp_int_sid * 100 - client_id, item_grp_int_sid * 100 + client_id) AS
 item_grp_int_mstr_sid,
 item_grp_int_gid,
 IF(item_grp_int_gid < 0, item_grp_int_gid * 100 - client_id, item_grp_int_gid * 100 + client_id) AS
 item_grp_int_mstr_gid,
 item_grp_int_name,
 item_grp_int_src_cd,
 item_grp_int_descr,
 item_grp_int_int_descr,
 valid_from_dt,
 valid_to_dt,
 version_nr,
 current_fg,
 scd_key_md,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_dim_item_grp_int_2
WHERE deleted_fg = 0
 AND reject_fg = 0;