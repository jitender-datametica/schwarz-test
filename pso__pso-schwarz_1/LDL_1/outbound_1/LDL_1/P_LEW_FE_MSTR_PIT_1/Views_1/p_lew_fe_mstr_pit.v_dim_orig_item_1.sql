/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_ORIG_ITEM_1
#-------------------------------------------------------------------------------
# Description: CREATE VIEW fOR V_DIM_ORIG_ITEM_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli  Initial version
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2  2023-07-07 Andreas Kurz		Extend Output on BRAND_NAME and BRAND_TYPE_CD
#  2.3	2023-11-02 Andreas Kurz		added COALESCE(BRAND_NAME,'n/A') AS BRAND_NAME
#  3.0  2024-02-14 Prasanna Ranjan	Added new columns for PIT Increment 2 (PV)
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
ORIG_ITEM_MSTR_NR
ORIG_ITEM_MSTR_GID
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S; 
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT

SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ORIG_ITEM_1');

DESC TABLE P_LEW_MART_PIT.T_DIM_ORIG_ITEM_1;

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_ORIG_ITEM_1

*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_orig_item_1
OPTIONS(DESCRIPTION = `SOURCE VIEW DIMENSION NAN - NATIONAL ARTICEL NUMBER (ORIG ITEM_1 NUMBER)`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 orig_item_nr,
 IF(orig_item_nr < 0, orig_item_nr * 100 - client_id, orig_item_nr * 100 + client_id) AS orig_item_mstr_nr,
 orig_item_gid,
 IF(orig_item_gid < 0, orig_item_gid * 100 - client_id, orig_item_gid * 100 + client_id) AS orig_item_mstr_gid,
 dat_valid_from,
 item_name,
 item_descr,
 item_int_descr,
 item_fam_grp_sid,
 sub_item_grp_sid,
 item_grp_int_sid,
 brand_type_cd,
 brand_sid,
 COALESCE(brand_name, 'n/A') AS brand_name,
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
FROM ldl_p_lew_mart_pit.t_dim_orig_item_1
WHERE reject_fg = 0;