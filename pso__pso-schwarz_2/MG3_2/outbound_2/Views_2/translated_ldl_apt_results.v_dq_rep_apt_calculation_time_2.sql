CREATE OR REPLACE VIEW idq_production_ldl_apt_results.v_dq_rep_apt_calculation_time_2 (id, ref_calculation_time,
ref_day_id, ref_country_id, week_12_before, week_11_before, week_10_before, week_9_before, week_8_before, week_current,
week_8_after, week_9_after, week_10_after, week_11_after, week_12_after) AS SELECT ROW_NUMBER() OVER (ORDER BY
    ref_country_id IS NULL, ref_country_id, ref_calculation_time IS NULL, ref_calculation_time) AS id,
 ref_calculation_time,
 ref_day_id,
 ref_country_id,
 week_12_before,
 week_11_before,
 week_10_before,
 week_9_before,
 week_8_before,
 week_current,
 week_8_after,
 week_9_after,
 week_10_after,
 week_11_after,
 week_12_after
FROM idq_production_ldl_apt_results.t_dq_rep_apt_calculation_time_2;