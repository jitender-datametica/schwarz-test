CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_t_fact_iot_setpoint_per_day (mandant_id, wup_id, nb_id, cal_dt
, dat_von, dat_bis, device_id, supply_airtemp_meas, return_airtemp_meas, liquefactiontemp_meas,
liquefactiontemp_compound_meas, temp_meas, lowtemp_meas, defrost_limittemp_meas) AS SELECT V01.mandant_id,
 V03.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V02.dat AS cal_dt,
 V01.dat_von,
 V01.dat_bis,
 V01.device_id,
 V01.supply_airtemp_meas,
 V01.return_airtemp_meas,
 V01.liquefactiontemp_meas,
 V01.liquefactiontemp_compound_meas,
 V01.temp_meas,
 V01.lowtemp_meas,
 V01.defrost_limittemp_meas
FROM kfl_production_dbp_view.v_t_fact_iot_setpoint_per_day AS V01
 INNER JOIN kfl_production_dbp_view.v_tag AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis
 INNER JOIN kfl_production_dbp_view.v_wup AS V03 ON V01.wup_id = V03.wup_id AND V01.mandant_id = V03.mandant_id;