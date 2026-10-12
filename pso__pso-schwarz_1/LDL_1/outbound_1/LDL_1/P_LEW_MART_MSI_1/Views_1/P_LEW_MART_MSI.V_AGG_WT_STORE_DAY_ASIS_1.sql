CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_wt_store_day_asis_1 AS SELECT client_id,
 loc_sid_store AS st_loc_sid,
 dwh_cal_dt AS dat_working,
 work_time_gross_hr AS working_time_brutto_hrs,
 work_time_net_hr AS time_working_netto_hrs,
 break_hr AS break_hrs,
 perform_relev_absence_hr AS perf_rel_absence_hrs
FROM ldl_p_lew_bil_ac.v_agg_work_time_store_day_1;