CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_dim_cal_business_year_2 (bus_year, bus_year_begin_month, bus_year_end_month,
bus_year_begin_week_part, bus_year_end_week_part, bus_year_begin_dt, bus_year_end_dt, bus_year_week_cnt,
bus_year_week_part_cnt, bus_year_day_cnt, bus_year_prev_1y, bus_year_prev_2y, bus_year_prev_3y, bus_year_prev_4y,
bus_year_prev_5y, bus_year_offset, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_bil_ac.v_dim_cal_business_year_2 AS CALBY;