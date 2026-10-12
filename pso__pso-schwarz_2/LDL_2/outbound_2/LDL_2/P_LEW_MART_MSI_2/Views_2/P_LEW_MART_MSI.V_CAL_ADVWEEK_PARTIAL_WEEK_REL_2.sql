CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_advweek_partial_week_rel_2 (cy_week, cy_week_partial_week_id1,
cy_week_partial_week_id2, cy_week_partial_week_name, cy_month, byr, cy_week_partial_week_id) AS SELECT cy_week,
 cy_week_partial_week_id1,
 cy_week_partial_week_id2,
 cy_week_partial_week_name,
 cy_month,
 byr,
 cy_week_partial_week_id
FROM ldl_p_lew_mart_msi.t_cal_advweek_partial_week_rel_2;