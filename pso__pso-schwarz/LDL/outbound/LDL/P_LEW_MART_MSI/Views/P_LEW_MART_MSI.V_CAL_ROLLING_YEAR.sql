CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_rolling_year (month_until_id, month_until_sequence, rolling_year_type_id
, rolling_month_id) AS SELECT month_until_id,
 month_until_sequence,
 rolling_year_type_id,
 rolling_month_id
FROM ldl_p_lew_mart_msi.t_cal_rolling_year;