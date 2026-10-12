CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_t_dim_iot_device_2 (device_id, device_number, device_model,
device_location) AS SELECT device_id,
 device_number,
 device_model,
 device_location
FROM kfl_production_dbp_view.v_t_dim_iot_device_2 AS V01;