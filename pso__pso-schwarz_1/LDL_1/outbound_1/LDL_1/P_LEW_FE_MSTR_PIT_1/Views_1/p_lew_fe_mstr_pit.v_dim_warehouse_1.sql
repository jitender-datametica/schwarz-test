/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_DIM_WAREHOUSE_1
#-------------------------------------------------------------------------------
# Describtion: CREATE VIEW fOR V_DIM_WAREHOUSE_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli  Initial version
#  2.1	2022-07-18 Andreas Kurz		Reworked structure
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/
/*
VC: 
WAREHOUSE_MSTR_SID
WAREHOUSE_MSTR_GID
ORIG_WH_NR_NAME
*/
/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_WAREHOUSE_1');

DESC TABLE P_LEW_MART_PIT.T_DIM_WAREHOUSE_1;

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_WAREHOUSE_1

*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_warehouse_1
OPTIONS(DESCRIPTION = `SOURCE VIEW DIMENSION WAREHOUSE - LEVEL`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 warehouse_sid,
 IF(warehouse_sid < 0, warehouse_sid * 100 - client_id, warehouse_sid * 100 + client_id) AS warehouse_mstr_sid,
 warehouse_gid,
 IF(warehouse_gid < 0, warehouse_gid * 100 - client_id, warehouse_gid * 100 + client_id) AS warehouse_mstr_gid,
 warehouse_name,
 orig_wh_nr,
 IF(warehouse_sid < 0, warehouse_name || ' - ' || country_descr, TRIM(SAFE_CAST(orig_wh_nr as STRING)) || ' - ' ||
   warehouse_name) AS orig_wh_nr_name,
  CASE
  WHEN orig_wh_nr >= 0
  THEN orig_wh_nr
  ELSE NULL
  END AS orig_wh_nr_positive,
 region_type_id,
 region_type_descr,
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
FROM ldl_p_lew_mart_pit.t_dim_warehouse_1
WHERE deleted_fg = 0
 AND reject_fg = 0;