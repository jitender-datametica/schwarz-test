CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_sod_ava_threshold (threshold_name, threshold_value, threshold_value_02
, threshold_value_03, threshold_value_04, threshold_value_05, threshold_value_06, threshold_value_07, threshold_value_08
, threshold_value_09) AS SELECT threshold_name,
 threshold_value,
  threshold_value - threshold_value / 9 AS threshold_value_02,
  threshold_value - 2 * (threshold_value / 9) AS threshold_value_03,
  threshold_value - 3 * (threshold_value / 9) AS threshold_value_04,
  threshold_value - 4 * (threshold_value / 9) AS threshold_value_05,
  threshold_value - 5 * (threshold_value / 9) AS threshold_value_06,
  threshold_value - 6 * (threshold_value / 9) AS threshold_value_07,
  threshold_value - 7 * (threshold_value / 9) AS threshold_value_08,
  threshold_value - 8 * (threshold_value / 9) AS threshold_value_09
FROM ldl_fe_mstr_ai_reporting.t_sod_ava_threshold;