CREATE OR REPLACE VIEW kfl_production_dbp_view.v_t_fact_iot_compound_per_hour_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 cal_dt,
 device_id,
 measurement_tm,
 liquefactiontemp_actual_meas,
 liquefactiontemp_setpoint_meas,
 roomtemp_meas,
 evaporationtemp_actual_meas,
 evaporation_pressure_meas
FROM kfl_production_dbp_data.t_fact_iot_compound_per_hour_1;