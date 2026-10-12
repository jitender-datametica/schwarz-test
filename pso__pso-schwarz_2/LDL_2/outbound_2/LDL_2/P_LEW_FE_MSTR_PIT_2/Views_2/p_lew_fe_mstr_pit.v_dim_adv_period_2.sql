/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_PERIOD
#-------------------------------------------------------------------------------
# Description: Create View for Calendar_2 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz	    Initial version
#  1.1 	2022-03-21 Andreas Kurz		Added furtehr columns to view
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure 
#  2.2  2022-08-23 Andreas Kurz		Added AND PROCESSED_ADV_PERIOD_FG = 1
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
ADV_WEEK_MSTR_ID
ADV_PERIOD_MSTR_ID
ADV_PERIOD_DAYS_ID
ADV_WEEK_WEEK_NR
ADV_WEEK_YEAR_ID
ADV_WEEK_LDESCR
ADV_PERIOD_START_DT_DESCR
ADV_PERIOD_END_DT_DESCR
ADV_PERIOD_DESCR
ADV_PERIOD_SDESCR
ADV_PERIOD_LDESCR
ADV_PERIOD_XLDESCR
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_MART_PIT.T_DIM_ADV_PERIOD_2');
DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_PERIOD_2

DROP VIEW LDL.P_LEW_MART_PIT.V_DIM_ADV_PERIOD_2

*/

/*
---------------------------------------------------------------------
0. Create View Table in V_DIM_ADV_PERIOD_2
------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_period_2
OPTIONS(DESCRIPTION = `VIEW TABLE ADV-PERIOD (ONLY VALID RECORDS)`) AS SELECT client_id,
 country_iso_cd,
 country_descr,
 ctr_adv_week_start_weekday_id,
 adv_week_id,
   adv_week_id * 100 + client_id AS adv_week_mstr_id,
 adv_week_start_dt,
 adv_week_end_dt,
 adv_period_start_dt,
 adv_period_end_dt,
 cast(FORMAT_DATE('%u',adv_period_start_dt) as INTEGER) AS adv_period_start_day_id,
 cast(FORMAT_DATE('%u',adv_period_end_dt) as INTEGER) AS adv_period_end_day_id,
 adv_period_length_in_days,
 adv_period_start_day_sdescr,
 adv_period_end_day_sdescr,
 adv_period_start_day_descr,
 adv_period_end_day_descr,
 overlap_period_fg,
 overlap_adv_period_start_dt,
 overlap_adv_period_end_dt,
 DATE_DIFF(DATE(overlap_adv_period_end_dt), DATE(overlap_adv_period_start_dt), DAY) AS overlap_adv_period_length_in_days
 ,
 overlap_adv_week_id,
 current_adv_period_fg,
 adv_period_id,
 CAST(adv_period_id * 100 + client_id AS STRING) AS adv_period_mstr_id,
 cast(FORMAT_DATE('%u',adv_period_start_dt) as INTEGER)+cast(FORMAT_DATE('%u',adv_period_end_dt) as INTEGER) AS adv_period_days_id,
 processed_adv_period_fg,
 mov_adv_period_start_from_current,
 mov_adv_period_id_from_start_nr,
 reject_fg,
 reject_reason_id,
 source_system_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id,
 MOD(adv_week_id, 100) AS adv_week_week_nr,
 ROUND(SAFE_CAST(SUBSTR(CAST(adv_week_id AS STRING), 1, 4) AS BIGNUMERIC), 0) AS adv_week_year_id,
 TRIM(CAST(MOD(adv_week_id, 100) AS STRING FORMAT '09') || '/' || CAST(ROUND(SAFE_CAST(SUBSTR(CAST(adv_week_id AS STRING)
       , 1, 4) AS BIGNUMERIC), 0) AS STRING)) AS adv_week_ldescr,
 TRIM(FORMAT_DATE('%d.%m.%Y', adv_period_start_dt)) AS adv_period_start_dt_descr,
 TRIM(FORMAT_DATE('%d.%m.%Y', adv_period_end_dt)) AS adv_period_end_dt_descr,
 TRIM(TRIM(CAST(MOD(adv_week_id, 100) AS STRING FORMAT '09') || '/' || CAST(ROUND(SAFE_CAST(SUBSTR(CAST(adv_week_id AS STRING)
            , 1, 4) AS BIGNUMERIC), 0) AS STRING)) || ': ' || adv_period_start_day_sdescr || '-' ||
   adv_period_end_day_sdescr) AS adv_period_descr,
 TRIM(adv_period_start_day_sdescr || '-' || adv_period_end_day_sdescr) AS adv_period_sdescr,
 TRIM(adv_period_start_day_sdescr || ' ' || TRIM(FORMAT_DATE('%d.%m.%Y', adv_period_start_dt)) || ' bis ' ||
     adv_period_end_day_sdescr || ' ' || TRIM(FORMAT_DATE('%d.%m.%Y', adv_period_end_dt))) AS adv_period_ldescr,
 TRIM('Periode: von: ' || adv_period_start_day_descr || ' ' || TRIM(FORMAT_DATE('%d.%m.%Y', adv_period_start_dt)) ||
        ' bis: ' || adv_period_end_day_descr || ' ' || TRIM(FORMAT_DATE('%d.%m.%Y', adv_period_end_dt)) ||
    ' in Werbewoche: ' || TRIM((CAST(MOD(adv_week_id, 100) AS STRING FORMAT '09') || '/' || CAST(ROUND(SAFE_CAST(SUBSTR(CAST(adv_week_id AS STRING)
          , 1, 4) AS BIGNUMERIC), 0) AS STRING)))) AS adv_period_xldescr,
 adv_week_period_sort_val
FROM ldl_p_lew_mart_pit.t_dim_adv_period_2
WHERE deleted_fg = 0
 AND reject_fg = 0 -- AND PROCESSED_ADV_PERIOD_FG = 1
;
