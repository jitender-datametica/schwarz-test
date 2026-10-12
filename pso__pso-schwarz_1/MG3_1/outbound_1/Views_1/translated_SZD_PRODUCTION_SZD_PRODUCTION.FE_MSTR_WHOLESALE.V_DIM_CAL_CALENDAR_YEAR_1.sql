CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_dim_cal_calendar_year_1 (cy, cy_begin_month, cy_end_month,
cy_begin_week_part, cy_end_week_part, cy_begin_dt, cy_end_dt, cy_week_cnt, cy_week_part_cnt, cy_day_cnt, cy_prev_1y,
cy_prev_2y, cy_prev_3y, cy_prev_4y, cy_prev_5y, cy_offset, dwh_src_file_name, dwh_created_tmsp, dwh_updated_tmsp) AS
SELECT *
FROM szd_production_core.t_dim_cal_calendar_year_1;