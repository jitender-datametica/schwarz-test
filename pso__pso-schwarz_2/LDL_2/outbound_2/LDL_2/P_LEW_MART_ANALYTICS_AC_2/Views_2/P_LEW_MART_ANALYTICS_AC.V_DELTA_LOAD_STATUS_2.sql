CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_delta_load_status_2 (delta_name, delta_timestamp_val) AS SELECT
 delta_name,
 delta_timestamp_val
FROM ldl_p_lew_mart_analytics.t_delta_load_status_2;