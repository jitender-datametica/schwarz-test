CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_t_fact_iot_building_1 (mandant_id, wup_id, nb_id, cal_dt,
device_id, measurement_tm, outdoortemp_condenser_supplyair_meas) AS SELECT V01.mandant_id,
 COALESCE(V02.aktuell_wup_id, V01.wup_id) AS wup_id,
 V01.nb_id,
 V01.cal_dt,
 V01.device_id,
 V01.measurement_tm,
 V01.outdoortemp_condenser_supplyair_meas
FROM kfl_production_dbp_view.v_t_fact_iot_building_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id;