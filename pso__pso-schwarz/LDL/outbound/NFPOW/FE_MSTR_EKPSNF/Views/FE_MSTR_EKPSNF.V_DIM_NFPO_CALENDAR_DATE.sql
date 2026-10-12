CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_calendar_date (cal_dt, cal_week, nfpo_cal_week_name,
cal_week_begin_dt, cal_month, cal_year, bus_year, day_of_week, day_of_month, day_of_cal_year, ldl_cal_dt_offset,
dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_nfpo_calendar_date;