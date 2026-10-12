CREATE OR REPLACE VIEW kfl_production_dbp_view.v_t_fact_iot_building_1 AS SELECT mandant_id,
 wup_id,
 nb_id,
 cal_dt,
 device_id,
 measurement_tm,
 outdoortemp_condenser_supplyair_meas
FROM kfl_production_dbp_data.t_fact_iot_building_1;