CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_fact_charge_log_events (charger_provider_system_cd, charge_log_uuid_nr
, charge_event_dt, cy_month, cy, start_tmsp, end_tmsp, charger_resource_item_sid, charger_classification_id,
charger_serial_nr, charger_label_nr, division_party_sid, division_name, country_location_sid, iso_country_cd,
internal_company_name, real_estate_resource_item_sid, real_estate_nr, real_estate_zip, real_estate_city_name,
real_estate_street_name, charge_point_resource_item_sid, charge_point_plugin_type_name, charger_station_type_cd,
charge_point_nr, charge_point_evse_nr, charge_point_connector_label_txt, roaming_identification_data_txt,
customer_uuid_nr, authentication_method_cd, duration_sec, total_charging_power_meas, average_charging_power_meas,
turnover_val, turnover_local_val, turnover_local_curr_cd) AS SELECT A.charger_provider_system_cd,
 A.charge_log_uuid_nr,
 A.charge_event_dt,
 B.cy_month,
 B.cy,
 CAST(A.start_tmsp AS DATETIME) AS start_tmsp,
 CAST(A.end_tmsp AS DATETIME) AS end_tmsp,
 A.charger_resource_item_sid,
 A.charger_classification_id,
 A.charger_serial_nr,
 A.charger_label_nr,
 A.division_party_sid,
 A.division_name,
  CASE
  WHEN A.country_iso_cd = 'AF'
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE A.country_location_sid
  END AS country_location_sid,
  CASE
  WHEN A.country_iso_cd = 'AF'
  THEN 'Unknown'
  ELSE A.country_iso_cd
  END AS iso_country_cd,
 A.internal_company_name,
 A.real_estate_resource_item_sid,
 A.real_estate_nr,
 A.real_estate_zip,
 A.real_estate_city_name,
 A.real_estate_street_name,
 A.charge_point_resource_item_sid,
 A.charge_point_plugin_type_cd AS charge_point_plugin_type_name,
 A.charger_station_type_cd,
 A.charge_point_nr,
 A.charge_point_evse_nr,
 A.charge_point_connector_label_txt,
 A.roaming_identification_data_txt,
 A.customer_uuid_nr,
 A.authentication_method_cd,
 A.duration_sec,
 A.total_charging_power_meas,
 A.average_charging_power_meas,
 A.turnover_val,
 A.turnover_local_val,
 A.local_curr_cd AS turnover_local_curr_cd
FROM szd_core.t_fact_charge_log_events AS A
 INNER JOIN szd_fe_mstr_iotchargers.v_dim_cal_day AS B ON A.charge_event_dt = B.cal_dt
WHERE CAST(A.end_tmsp AS DATE) BETWEEN DATE_ADD(CURRENT_DATE, INTERVAL - 14 MONTH) AND (CURRENT_DATE)
 AND A.turnover_val BETWEEN 0.0 AND 100.0
 AND A.duration_sec BETWEEN 0.0 AND 86400.0
 AND A.country_iso_cd IS NOT NULL
 AND A.end_tmsp IS NOT NULL;