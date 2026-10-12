CREATE OR REPLACE VIEW kfl_production_dbp_view.v_t_fact_iot_errormessages_1 AS SELECT mandant_id,
 wup_id,
 device_id,
 fault_nr,
 cal_dt,
 measurement_tmsp,
 device_type_id,
 alarm_priority_cd,
 error_source,
 error_message,
 value_cycling,
 active_fg
FROM kfl_production_dbp_data.t_fact_iot_errormessages_1;