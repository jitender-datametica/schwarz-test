CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_price_label_sensor_state_hist_2 (client_id, price_label_sid,
price_label_sensor_name, price_label_metric_meas, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 price_label_sid,
 price_label_sensor_name,
 price_label_metric_meas,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_price_label_sensor_state_hist_2;