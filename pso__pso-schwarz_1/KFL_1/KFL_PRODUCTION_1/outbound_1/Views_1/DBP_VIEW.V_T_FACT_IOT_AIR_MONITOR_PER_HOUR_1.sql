CREATE OR REPLACE VIEW kfl_production_dbp_view.v_t_fact_iot_air_monitor_per_hour_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 cal_dt,
 device_id,
 measurement_tm,
 hygrometertemp_meas,
 hygrometerhumidity_meas
FROM kfl_production_dbp_data.t_fact_iot_air_monitor_per_hour_1;