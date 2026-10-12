/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_ITEM_FAMILY_GRP_2
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_DIM_ITEM_FAMILY_GRP_2
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
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_item_family_grp_2
OPTIONS(DESCRIPTION = `SOURCE VIEW DIMENSION ITEM_2 FAMILY GROUP`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 item_fam_grp_sid,
 IF(item_fam_grp_sid < 0, item_fam_grp_sid * 100 - client_id, item_fam_grp_sid * 100 + client_id) AS
 item_fam_grp_mstr_sid,
 item_fam_grp_gid,
 IF(item_fam_grp_gid < 0, item_fam_grp_gid * 100 - client_id, item_fam_grp_gid * 100 + client_id) AS
 item_fam_grp_mstr_gid,
 item_fam_grp_src_id,
 item_fam_grp_src_cd,
 item_fam_grp_name,
 item_fam_grp_descr,
 item_fam_grp_int_descr,
 sub_item_grp_sid,
 IF(sub_item_grp_sid < 0, sub_item_grp_sid * 100 - client_id, sub_item_grp_sid * 100 + client_id) AS
 sub_item_grp_mstr_sid,
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
FROM ldl_p_lew_mart_pit.t_dim_item_family_grp_2
WHERE deleted_fg = 0
 AND reject_fg = 0;