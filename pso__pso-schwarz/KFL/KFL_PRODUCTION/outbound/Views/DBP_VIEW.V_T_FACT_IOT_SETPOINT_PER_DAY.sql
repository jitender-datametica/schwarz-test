CREATE OR REPLACE VIEW kfl_production_dbp_view.v_t_fact_iot_setpoint_per_day AS SELECT mandant_id,
 wup_id,
 nb_id,
 dat_von,
 dat_bis,
 device_id,
 supply_airtemp_meas,
 return_airtemp_meas,
 liquefactiontemp_meas,
 liquefactiontemp_compound_meas,
 temp_meas,
 defrost_limittemp_meas,
 lowtemp_meas
FROM kfl_production_dbp_data.t_fact_iot_setpoint_per_day;