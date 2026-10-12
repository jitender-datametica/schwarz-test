CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_WT_STORE_DAY_ASIS as
   SELECT client_id,
   loc_sid_store AS st_loc_sid,
   dwh_cal_dt AS dat_working,
   work_time_gross_hr AS working_time_brutto_hrs,
   work_time_net_hr AS time_working_netto_hrs,
   break_hr AS break_hrs,
   perform_relev_absence_hr AS perf_rel_absence_hrs
  FROM p_lew_bil_ac.v_agg_work_time_store_day
;