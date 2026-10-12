CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_cal_day_py_swday_business_year_adjusted (cal_dt, cy_week_part,
bus_year_diff, incl_cal_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_cal_day_py_swday_business_year_adjusted AS CALDAY;