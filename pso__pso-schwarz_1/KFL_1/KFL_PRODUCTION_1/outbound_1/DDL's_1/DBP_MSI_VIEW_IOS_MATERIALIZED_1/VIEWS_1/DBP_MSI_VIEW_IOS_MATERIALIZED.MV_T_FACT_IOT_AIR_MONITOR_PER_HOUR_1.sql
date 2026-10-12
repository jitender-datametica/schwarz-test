CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_t_fact_iot_air_monitor_per_hour_1 (mandant_id, wup_id, nb_id,
cal_dt, device_id, measurement_tm, hygrometertemp_meas, hygrometerhumidity_meas) AS SELECT V01.mandant_id,
 COALESCE(W.wup_id, V01.wup_id) AS wup_id,
 V01.nb_id,
 V01.cal_dt,
 V01.device_id,
 V01.measurement_tm,
 V01.hygrometertemp_meas,
 V01.hygrometerhumidity_meas
FROM kfl_production_dbp_view.v_t_fact_iot_air_monitor_per_hour_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W ON V01.wup_id = W.wup_id AND V01.mandant_id = W.mandant_id;