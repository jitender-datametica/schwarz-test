/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2023
#-------------------------------------------------------------------------------
# Interface : View for T_DIM_ADV_WEEK_2_ADV_WEEK_PREV
#-------------------------------------------------------------------------------
# Describtion: Create Frontend View for T_DIM_ADV_WEEK_2_ADV_WEEK_PREV
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-01-17 Andreas Kurz	    Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
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
--SELECT GET_DDL('view','P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2_ADV_WEEK_PREV');
--DESC VIEW LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_2_ADV_WEEK_PREV;
--DESC TABLE LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN.P_LEW_FE_MSTR_PIT.T_DIM_ADV_WEEK_2_ADV_WEEK_PREV;
--DESC TABLE LDL_PRODUCTION_CLONE_PIT.P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP;
--SELECT * FROM LDL_PRODUCTION_CLONE_PIT.P_LEW_FE_MSTR_PIT.V_DIM_ADV_THEME_GRP LIMIT 1;
*/

/* 
---------------------------------------------------------------------
Create Access View p_lew_fe_mstr_pit.v_dim_adv_week_2_adv_week_prev 
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_week_2_adv_week_prev
OPTIONS(DESCRIPTION = `VIEW DIMENSION DIM_ADV_WEEK_2_ADV_WEEK_PREV`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 adv_week_id,
   adv_week_id * 100 + client_id AS adv_week_mstr_id,
 TRIM(CAST(MOD(adv_week_id, 100) AS STRING FORMAT '09') || '/' || CAST(ROUND(SAFE_CAST(SUBSTR(CAST(adv_week_id AS STRING)
       , 1, 4) AS BIGNUMERIC), 0) AS STRING)) AS adv_week_descr,
 rltd_adv_week_id,
   rltd_adv_week_id * 100 + client_id AS rltd_adv_week_mstr_id,
 TRIM(CAST(MOD(rltd_adv_week_id, 100) AS STRING FORMAT '09') || '/' || CAST(ROUND(SAFE_CAST(SUBSTR(CAST(rltd_adv_week_id AS STRING)
       , 1, 4) AS BIGNUMERIC), 0) AS STRING)) AS rltd_adv_week_descr,
 rltd_adv_week_start_dt,
 rltd_adv_week_end_dt,
 diff_adv_week_nr,
 nearest_rltd_adv_week_fg,
 related_type_id,
 related_type_descr,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_fe_mstr_pit.t_dim_adv_week_2_adv_week_prev AS AGG
WHERE deleted_fg = 0
 AND reject_fg = 0;