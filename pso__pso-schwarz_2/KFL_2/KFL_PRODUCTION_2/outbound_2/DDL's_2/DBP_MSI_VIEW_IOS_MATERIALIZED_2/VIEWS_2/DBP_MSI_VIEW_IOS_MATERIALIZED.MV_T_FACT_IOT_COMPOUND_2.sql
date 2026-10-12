CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_t_fact_iot_compound_2 (mandant_id, wup_id, nb_id, cal_dt,
device_id, measurement_tm, liquefactiontemp_actual_meas, liquefactiontemp_setpoint_meas, roomtemp_meas,
evaporationtemp_actual_meas, evaporation_pressure_meas) AS SELECT V01.mandant_id,
 COALESCE(V02.aktuell_wup_id, V01.wup_id) AS wup_id,
 V01.nb_id,
 V01.cal_dt,
 V01.device_id,
 V01.measurement_tm,
 V01.liquefactiontemp_actual_meas,
 V01.liquefactiontemp_setpoint_meas,
 V01.roomtemp_meas,
 V01.evaporationtemp_actual_meas,
 V01.evaporation_pressure_meas
FROM kfl_production_dbp_view.v_t_fact_iot_compound_2 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_2 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id;