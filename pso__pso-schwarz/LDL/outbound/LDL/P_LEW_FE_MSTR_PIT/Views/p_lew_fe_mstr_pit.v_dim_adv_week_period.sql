/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_PERIOD, joined with DIM_ADV_WEEK
#-------------------------------------------------------------------------------
# Description: Combining info fields of adv period with additional adv week fields.
#              This is just to provide an interface for the MSTR schema (migrated from PITonPrem to PITonCloud):
#              The MSTR attribute "Werbeperiode Start Ende Datum" uses period and adv week fields.
#              Later this attribute could be replaced in all reports by the 2 attributes Werbeperiode, Werbewoche.
#              Especially the info window in all Documents would need to be adjusted to show the "Maximale Laufzeit ..."
#              from the Werbewoche attribute.
#              Then, this view will be obsolete.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-06-02 Dirk Hering      Initial version
#  2.0	2022-07-16 Nikolai Toknov  	Changing the script for DevOps
#  2.1	2022-07-18 Andreas Kurz		Reworked structure
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC. 
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PERIOD');

DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_PERIOD;
DESC TABLE P_LEW_MART_PIT.T_DIM_ADV_WEEK;
           

DROP VIEW LDL.P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PERIOD

*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_week_period
OPTIONS(DESCRIPTION = `VIEW ADV-PERIOD WITH ADDED ADV-WEEK FIELDS`) AS -- Adv Week
 SELECT adp.client_id,
 adp.country_iso_cd,
 adp.country_descr,
 adp.ctr_adv_week_start_weekday_id,
 adp.adv_period_start_dt,
 adp.adv_period_end_dt,
 adp.adv_period_start_day_id,
 adp.adv_period_end_day_id,
 adp.adv_period_length_in_days,
 adp.adv_period_start_day_sdescr,
 adp.adv_period_end_day_sdescr,
 adp.adv_period_start_day_descr,
 adp.adv_period_end_day_descr,
 adp.overlap_period_fg,
 adp.overlap_adv_period_start_dt,
 adp.overlap_adv_period_end_dt,
 adp.overlap_adv_period_length_in_days,
 adp.overlap_adv_week_id,
 adp.current_adv_period_fg,
 adp.adv_period_id,
 adp.adv_period_mstr_id,
 adp.processed_adv_period_fg,
 adp.mov_adv_period_start_from_current,
 adp.mov_adv_period_id_from_start_nr,
 adp.adv_period_start_dt_descr,
 adp.adv_period_end_dt_descr,
 adp.adv_period_descr,
 adp.adv_period_sdescr,
 adp.adv_period_ldescr,
 adp.adv_period_xldescr,
 adp.adv_week_period_sort_val -- Adv Week
,
 adw.adv_week_id,
 adw.adv_week_mstr_id,
 adw.adv_week_year_id,
 adw.adv_week_start_dt,
 adw.adv_week_end_dt,
 adw.adv_week_start_dt_descr,
 adw.adv_week_end_dt_descr,
 adw.length_of_adv_week,
 adw.adv_week_start_day_sdescr,
 adw.adv_week_end_day_sdescr,
 adw.adv_week_start_day_descr,
 adw.adv_week_end_day_descr,
 adw.adv_week_week_nr,
 adw.prev_1_adv_week_id,
 adw.prev_2_adv_week_id,
 adw.prev_3_adv_week_id,
 adw.prev_4_adv_week_id,
 adw.prev_5_adv_week_id,
 adw.prev_6_adv_week_id,
 adw.prev_7_adv_week_id,
 adw.prev_8_adv_week_id,
 adw.prev_9_adv_week_id,
 adw.next_1_adv_week_id,
 adw.prev_1_year_adv_week_id,
 adw.processed_adv_week_fg,
 adw.last_closed_adv_week_id,
 adw.last_adv_week_id,
 adw.last_adv_week_fg,
 adw.last_closed_adv_week_fg,
 adw.mov_adv_week_start_from_current,
 adw.mov_adv_week_id_from_start_nr,
 adw.max_adv_period_end_dt,
 adw.max_adv_period_end_day_sdescr,
 adw.max_adv_period_end_day_descr,
 adw.cnt_periods_of_adv_week_overlap,
 adw.sum_of_promotion_days_overlapping_in_adv_week,
 adw.cnt_periods_of_adv_week,
 adw.sum_of_promotion_days_in_adv_week,
 adw.adv_week_descr,
 adw.adv_week_ldescr,
 adw.adv_week_sdescr,
 adw.adv_week_overlap_ldescr
FROM (SELECT client_id,
   country_iso_cd,
   country_descr,
   ctr_adv_week_start_weekday_id,
   adv_week_id,
   adv_week_mstr_id,
   adv_week_start_dt,
   adv_week_end_dt,
   adv_period_start_dt,
   adv_period_end_dt,
   adv_period_start_day_id,
   adv_period_end_day_id,
   adv_period_length_in_days,
   adv_period_start_day_sdescr,
   adv_period_end_day_sdescr,
   adv_period_start_day_descr,
   adv_period_end_day_descr,
   overlap_period_fg,
   overlap_adv_period_start_dt,
   overlap_adv_period_end_dt,
   overlap_adv_period_length_in_days,
   overlap_adv_week_id,
   current_adv_period_fg,
   adv_period_id,
   adv_period_mstr_id,
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
   adv_week_week_nr,
   adv_week_year_id,
   adv_week_ldescr,
   adv_period_start_dt_descr,
   adv_period_end_dt_descr,
   adv_period_descr,
   adv_period_sdescr,
   adv_period_ldescr,
   adv_period_xldescr,
   adv_week_period_sort_val
  FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_period
  WHERE deleted_fg = 0
   AND reject_fg = 0) AS adp
 INNER JOIN (SELECT client_id,
   country_iso_cd,
   country_descr,
   ctr_adv_week_start_weekday_id,
   adv_week_id,
   adv_week_mstr_id,
   adv_week_year_id,
   adv_week_start_dt,
   adv_week_end_dt,
   adv_week_start_dt_descr,
   adv_week_end_dt_descr,
   length_of_adv_week,
   adv_week_start_day_sdescr,
   adv_week_end_day_sdescr,
   adv_week_start_day_descr,
   adv_week_end_day_descr,
   adv_week_week_nr,
   prev_1_adv_week_id,
   prev_2_adv_week_id,
   prev_3_adv_week_id,
   prev_4_adv_week_id,
   prev_5_adv_week_id,
   prev_6_adv_week_id,
   prev_7_adv_week_id,
   prev_8_adv_week_id,
   prev_9_adv_week_id,
   next_1_adv_week_id,
   prev_1_year_adv_week_id,
   processed_adv_week_fg,
   last_closed_adv_week_id,
   last_adv_week_id,
   last_adv_week_fg,
   last_closed_adv_week_fg,
   mov_adv_week_start_from_current,
   mov_adv_week_id_from_start_nr,
   max_adv_period_end_dt,
   max_adv_period_end_day_sdescr,
   max_adv_period_end_day_descr,
   cnt_periods_of_adv_week_overlap,
   sum_of_promotion_days_overlapping_in_adv_week,
   cnt_periods_of_adv_week,
   sum_of_promotion_days_in_adv_week,
   reject_fg,
   reject_reason_id,
   source_system_id,
   deleted_fg,
   dwh_created_ts,
   dwh_updated_ts,
   load_id,
   adv_week_descr,
   adv_week_ldescr,
   adv_week_sdescr,
   adv_week_overlap_ldescr
  FROM ldl_p_lew_fe_mstr_pit.v_dim_adv_week
  WHERE deleted_fg = 0
   AND reject_fg = 0) AS adw ON adp.client_id = adw.client_id AND adp.adv_week_id = adw.adv_week_id;


-- SELECT * FROM LDL.P_LEW_FE_MSTR_PIT.V_DIM_ADV_WEEK_PERIOD LIMIT 10;