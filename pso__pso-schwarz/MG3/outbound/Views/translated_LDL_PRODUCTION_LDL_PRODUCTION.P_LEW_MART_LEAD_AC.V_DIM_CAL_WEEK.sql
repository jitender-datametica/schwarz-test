CREATE OR REPLACE VIEW ldl_production_p_lew_mart_lead_ac.v_dim_cal_week (cy_week, week_of_year, cy_week_begin_week_part
, cy_week_end_week_part, cy_week_begin_dt, cy_week_end_dt, cy_week_week_part_cnt, cy_week_prev_1w, cy_week_prev_1y,
cy_week_prev_2y, cy_week_prev_3y, cy_week_prev_4y, cy_week_prev_5y, cy_week_offset, cy_week_short_name, cy_week_name,
dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_production_p_lew_mart_lead.v_dim_cal_week AS calwk;