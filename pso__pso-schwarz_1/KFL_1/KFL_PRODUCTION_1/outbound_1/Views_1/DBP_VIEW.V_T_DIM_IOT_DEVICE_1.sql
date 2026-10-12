CREATE OR REPLACE VIEW kfl_production_dbp_view.v_t_dim_iot_device_1 AS SELECT device_id,
 device_number,
 device_model,
 device_location
FROM kfl_production_dbp_data.t_dim_iot_device_1;