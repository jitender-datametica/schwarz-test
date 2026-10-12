CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_fact_charge_log_events_1 (charger_provider_system_cd,
charge_log_uuid_nr, charge_event_dt, cy_month, cy, start_tmsp, end_tmsp, charger_resource_item_sid,
charger_classification_id, charger_serial_nr, charger_label_nr, division_party_sid, division_name, country_location_sid
, iso_country_cd, internal_company_name, real_estate_resource_item_sid, real_estate_nr, real_estate_zip,
real_estate_city_name, real_estate_street_name, charge_point_resource_item_sid, charge_point_plugin_type_name,
charger_station_type_cd, charge_point_nr, charge_point_evse_nr, charge_point_connector_label_txt,
roaming_identification_data_txt, customer_uuid_nr, duration_sec, total_charging_power_meas, average_charging_power_meas
, turnover_val, turnover_local_val, turnover_local_curr_cd) AS SELECT a.charger_provider_system_cd,
 a.charge_log_uuid_nr,
 a.charge_event_dt,
 b.cy_month,
 b.cy,
 CAST(a.start_tmsp AS DATETIME) AS start_tmsp,
 CAST(a.end_tmsp AS DATETIME) AS end_tmsp,
 a.charger_resource_item_sid,
 a.charger_classification_id,
 a.charger_serial_nr,
 a.charger_label_nr,
 a.division_party_sid,
 a.division_name,
  CASE
  WHEN a.country_iso_cd = 'AF'
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE a.country_location_sid
  END AS country_location_sid,
  CASE
  WHEN a.country_iso_cd = 'AF'
  THEN 'Unknown'
  ELSE a.country_iso_cd
  END AS iso_country_cd,
 a.internal_company_name,
 a.real_estate_resource_item_sid,
 a.real_estate_nr,
 a.real_estate_zip,
 a.real_estate_city_name,
 a.real_estate_street_name,
 a.charge_point_resource_item_sid,
 a.charge_point_plugin_type_cd AS charge_point_plugin_type_name,
 a.charger_station_type_cd,
 a.charge_point_nr,
 a.charge_point_evse_nr,
 a.charge_point_connector_label_txt,
 a.roaming_identification_data_txt,
 a.customer_uuid_nr,
 a.duration_sec,
 a.total_charging_power_meas,
 a.average_charging_power_meas,
 a.turnover_val,
 a.turnover_local_val,
 a.local_curr_cd AS turnover_local_curr_cd
FROM szd_production_core.t_fact_charge_log_events_1 AS a
 INNER JOIN szd_production_fe_mstr_iotchargers.v_dim_cal_day_1 AS b ON a.charge_event_dt = b.cal_dt
WHERE CAST(a.end_tmsp AS DATE) BETWEEN DATE_ADD(CURRENT_DATE, INTERVAL - 14 MONTH) AND (CURRENT_DATE)
 AND a.turnover_val BETWEEN 0.0 AND 100.0
 AND a.duration_sec BETWEEN 0.0 AND 86400.0
 AND a.country_iso_cd IS NOT NULL
 AND a.end_tmsp IS NOT NULL;