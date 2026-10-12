/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_WEEK
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_2 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-12-20 Andreas Kurz	    Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC: 
ADV_WEEK_MSTR_ID
ADV_WEEK_YEAR_ID
ADV_WEEK_WEEK_NR
ADV_WEEK_DESCR
ADV_WEEK_LDESCR
ADV_WEEK_SDESCR
ADV_WEEK_OVERLAP_LDESCR
ADV_WEEK_START_DT_DESCR;
ADV_WEEK_END_DT_DESCR;
LENGTH_OF_ADV_WEEK;
*/
/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
--USE DATABASE	LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--SHOW DATABASES LIKE 'LDL_PRODUCTION_CLONE_PIT%';
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_week_2 OPTIONS(DESCRIPTION = `VIEW CONTROL ADV.-WEEK`) AS
-- Cube Loading
 -- AND CLIENT_ID = 1
 SELECT ADW.client_id,
 ADW.country_iso_cd,
 ADW.country_descr,
 ADW.ctr_adv_week_start_weekday_id,
 ADW.adv_week_id,
   ADW.adv_week_id * 100 + ADW.client_id AS adv_week_mstr_id,
 pa.start_adv_week_mstr_id_cube_load,
 pa.end_adv_week_mstr_id_cube_load,
 CAST(IF((ADW.adv_week_id * 100 + ADW.client_id) BETWEEN pa.start_adv_week_mstr_id_cube_load AND pa.end_adv_week_mstr_id_cube_load, 1, 0) AS BIGNUMERIC)
 AS cube_load_fg,
 ROUND(SAFE_CAST(SUBSTR(CAST(ADW.adv_week_id AS STRING), 1, 4) AS BIGNUMERIC), 0) AS adv_week_year_id,
 ADW.adv_week_start_dt,
 ADW.adv_week_end_dt,
 FORMAT_DATE('%d.%m.%Y', ADW.adv_week_start_dt) AS adv_week_start_dt_descr,
 FORMAT_DATE('%d.%m.%Y', ADW.adv_week_end_dt) AS adv_week_end_dt_descr,
  ROUND(CAST(DATE_DIFF(ADW.adv_week_end_dt,ADW.adv_week_start_dt, DAY) AS NUMERIC), 0) + 1 AS
 length_of_adv_week,
 ADW.adv_week_start_day_sdescr,
 ADW.adv_week_end_day_sdescr,
 ADW.adv_week_start_day_descr,
 ADW.adv_week_end_day_descr,
 MOD(ADW.adv_week_id, 100) AS adv_week_week_nr,
 TRIM(CAST(MOD(ADW.adv_week_id, 100) AS STRING FORMAT '09') || '/' || CAST(ROUND(SAFE_CAST(SUBSTR(CAST(ADW.adv_week_id AS STRING)
       , 1, 4) AS BIGNUMERIC), 0) AS STRING)) AS adv_week_descr,
 TRIM('Werbewoche: ' || TRIM((CAST(MOD(ADW.adv_week_id, 100) AS STRING FORMAT '09') || '/' || CAST(ROUND(SAFE_CAST(SUBSTR(CAST(ADW.adv_week_id AS STRING)
              , 1, 4) AS BIGNUMERIC), 0) AS STRING))) || ' von: ' || FORMAT_DATE('%d.%m.%Y', ADW.adv_week_start_dt) ||
    ' bis: ' || FORMAT_DATE('%d.%m.%Y', ADW.adv_week_end_dt)) AS adv_week_ldescr,
 TRIM(CAST(MOD(ADW.adv_week_id, 100) AS STRING FORMAT '09') || '/' || CAST(MOD(ROUND(SAFE_CAST(SUBSTR(CAST(ADW.adv_week_id AS STRING)
        , 1, 4) AS BIGNUMERIC), 0), 100) AS STRING)) AS adv_week_sdescr,
 ADW.prev_1_adv_week_id,
 ADW.prev_2_adv_week_id,
 ADW.prev_3_adv_week_id,
 ADW.prev_4_adv_week_id,
 ADW.prev_5_adv_week_id,
 ADW.prev_6_adv_week_id,
 ADW.prev_7_adv_week_id,
 ADW.prev_8_adv_week_id,
 ADW.prev_9_adv_week_id,
 ADW.next_1_adv_week_id,
 ADW.prev_1_year_adv_week_id,
 ADW.processed_adv_week_fg,
 ADW.last_closed_adv_week_id,
 ADW.last_adv_week_id,
 ADW.last_adv_week_fg,
 ADW.last_closed_adv_week_fg,
 ADW.mov_adv_week_start_from_current,
 ADW.mov_adv_week_id_from_start_nr,
 ADW.max_adv_period_end_dt,
 ADW.max_adv_period_end_day_sdescr,
 ADW.max_adv_period_end_day_descr,
 TRIM(ADW.adv_week_start_day_sdescr || ' ' || FORMAT_DATE('%d.%m.%Y', ADW.adv_week_start_dt) || ' bis ' || ADW.adv_week_end_day_sdescr
           || ' ' || FORMAT_DATE('%d.%m.%Y', ADW.adv_week_end_dt) || ' (Maximale Laufzeit bis ' || ADW.max_adv_period_end_day_sdescr
       || ' ' || FORMAT_DATE('%d.%m.%Y', ADW.max_adv_period_end_dt) || ')') AS adv_week_overlap_ldescr,
 ADW.cnt_periods_of_adv_week_overlap,
 ADW.sum_of_promotion_days_overlapping_in_adv_week,
 ADW.cnt_periods_of_adv_week,
 ADW.sum_of_promotion_days_in_adv_week,
 ADW.reject_fg,
 ADW.reject_reason_id,
 ADW.source_system_id,
 ADW.deleted_fg,
 ADW.dwh_created_ts,
 ADW.dwh_updated_ts,
 ADW.load_id
FROM ldl_p_lew_mart_pit.t_dim_adv_week_2 AS ADW
 INNER JOIN ldl_p_lew_fe_mstr_pit.v_cntl_processing_param_normalized_2 AS pa ON ADW.client_id = pa.client_id
WHERE ADW.deleted_fg = 0
 AND ADW.reject_fg = 0;