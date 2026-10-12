CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_t_fact_iot_cold_location (mandant_id, wup_id, nb_id, cal_dt,
device_id, measurement_tm, supply_airtemp_meas, return_airtemp_meas, superheat_meas, door_open_pct,
evaporator_active_qty, cooling_active_pct, temp_actual_meas) AS SELECT V01.mandant_id,
 COALESCE(V02.aktuell_wup_id, V01.wup_id) AS wup_id,
 V01.nb_id,
 V01.cal_dt,
 V01.device_id,
 V01.measurement_tm,
 V01.supply_airtemp_meas,
 V01.return_airtemp_meas,
 V01.superheat_meas,
 V01.door_open_pct,
 V01.evaporator_active_qty,
 V01.cooling_active_pct,
 V01.temp_actual_meas
FROM kfl_production_dbp_view.v_t_fact_iot_cold_location AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id;