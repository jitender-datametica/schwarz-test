CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ref_rolling_year_type_id AS SELECT month_until_id,
 rolling_year_type_id
FROM ldl_p_lew_mart_msi.v_cal_rolling_year
GROUP BY month_until_id,
 rolling_year_type_id;