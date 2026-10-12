CREATE OR REPLACE VIEW kfl_production_dbp_view.v_t_fact_iot_cold_location_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 cal_dt,
 device_id,
 measurement_tm,
 supply_airtemp_meas,
 return_airtemp_meas,
 superheat_meas,
 door_open_pct,
 evaporator_active_qty,
 cooling_active_pct,
 temp_actual_meas
FROM kfl_production_dbp_data.t_fact_iot_cold_location_1;