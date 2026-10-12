CREATE OR REPLACE VIEW dbp_msi_view_ios_materialized.mv_t_fact_iot_stoermeldungen (mandant_id, wup_id, device_id,
fault_nr, cal_dt, measurement_tmsp, alarm_priority_cd, error_message, value_cycling, device_type_id, error_source,
active_fg, active_fg_bez) AS SELECT V01.mandant_id,
 COALESCE(V02.aktuell_wup_id, V01.wup_id) AS wup_id,
 V01.device_id,
 V01.fault_nr,
 V01.cal_dt,
 V01.measurement_tmsp,
 V01.alarm_priority_cd,
 V01.error_message,
 V01.value_cycling,
 V01.device_type_id,
 V01.error_source,
 V01.active_fg,
  CASE
  WHEN V01.active_fg = 1
  THEN 'Start'
  WHEN V01.active_fg = 0
  THEN 'Ende'
  ELSE ''
  END AS active_fg_bez
FROM kfl_production_dbp_view.v_t_fact_iot_errormessages AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id;