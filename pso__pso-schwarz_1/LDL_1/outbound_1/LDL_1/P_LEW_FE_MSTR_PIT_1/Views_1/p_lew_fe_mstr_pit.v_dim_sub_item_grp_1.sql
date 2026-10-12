/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_SUB_ITEM_GRP_1
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_DIM_SUB_ITEM_GRP_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-18 Massimo Morelli  Initial version
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
SUB_ITEM_GRP_MSTR_SID
SUB_ITEM_GRP_MSTR_GID
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_SUB_ITEM_GRP_1');

DESC TABLE P_LEW_MART_PIT.T_DIM_SUB_ITEM_GRP_1;

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_SUB_ITEM_GRP_1

*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_sub_item_grp_1
OPTIONS(DESCRIPTION = `SOURCE VIEW DIMENSION UWG (UNTERWARENGRUPPE) - SUB ITEM_1 GROUP`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 sub_item_grp_sid,
 IF(sub_item_grp_sid < 0, sub_item_grp_sid * 100 - client_id, sub_item_grp_sid * 100 + client_id) AS
 sub_item_grp_mstr_sid,
 sub_item_grp_gid,
 IF(sub_item_grp_gid < 0, sub_item_grp_gid * 100 - client_id, sub_item_grp_gid * 100 + client_id) AS
 sub_item_grp_mstr_gid,
 sub_item_grp_name,
 sub_item_grp_src_cd,
 sub_item_grp_descr,
 sub_item_grp_int_descr,
 item_grp_int_sid,
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
FROM ldl_p_lew_mart_pit.t_dim_sub_item_grp_1
WHERE deleted_fg = 0
 AND reject_fg = 0;