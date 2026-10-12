BEGIN TRANSACTION;


TRUNCATE TABLE szd_production_core.${TST_PREFIX}t_fact_charge_point_analytical_per_day;


INSERT INTO szd_production_core.${TST_PREFIX}t_fact_charge_point_analytical_per_day (report_dt, charger_provider_system_cd,
 charge_point_resource_item_sid, charger_resource_item_sid, charging_station_owner_party_sid,
 real_estate_resource_item_sid, country_location_sid, division_party_sid, authentication_method_cd,
 charge_point_plugin_type_cd, charge_point_power_type_cd, charger_station_type_cd, curr_cd, local_curr_cd,
 provided_power_meas, charging_process_cnt, charging_duration_sec_meas, charging_performance_meas, turnover_eur_val,
 turnover_local_val, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT DATE(cl.end_local_tmsp) AS report_dt,
  cl.charger_provider_system_cd,
  cl.charge_point_resource_item_sid,
  cl.charger_resource_item_sid,
  COALESCE(chg.charging_station_owner_party_sid, - 1) AS charging_station_owner_party_sid,
  COALESCE(chg.real_estate_resource_item_sid, - 1) AS real_estate_resource_item_sid,
  COALESCE(res.country_location_sid, - 1) AS country_location_sid,
  COALESCE(res.division_party_sid, - 1) AS division_party_sid,
   CASE
   WHEN UPPER(cpt.charge_point_tariff_name) LIKE 'LIDL%'
   THEN 'LIDL-PLUS'
   WHEN UPPER(cpt.charge_point_tariff_name) LIKE 'KAUFLAND%'
   THEN 'KFL-APP'
   WHEN cl.roaming_interface_cd = 'ENERGISED'
   THEN 'ICR'
   WHEN cl.roaming_interface_cd = 'COMMUNITY'
   THEN CASE
    WHEN UPPER(emp.emp_name) = 'VIRTUAL DIRECT PAYMENT PROVIDER'
    THEN 'ADHOC'
    ELSE 'RCOM'
    END
   ELSE '-1'
   END AS authentication_method_cd,
  COALESCE(cpo.charge_point_plugin_type_cd, '-1') AS charge_point_plugin_type_cd,
  COALESCE(cpo.charge_point_power_type_cd, '-1') AS charge_point_power_type_cd,
  COALESCE(chg.charger_station_type_cd, '-1') AS charger_station_type_cd,
  'EUR' AS curr_cd,
  COALESCE(exr.source_currency_cd, '-1') AS local_curr_cd,
  SUM(COALESCE(cl.meter_total_meas / 1000, 0)) AS provided_power_meas,
  SUM(1) AS charging_process_cnt,
  SUM(TIMESTAMP_DIFF(CAST(cl.end_local_tmsp AS DATETIME), CAST(cl.start_local_tmsp AS DATETIME), SECOND)) AS
  charging_duration_sec_meas,
  SUM(COALESCE(cl.meter_total_meas / 1000 / TIMESTAMP_DIFF(CAST(cl.end_local_tmsp AS DATETIME), CAST(cl.start_local_tmsp AS DATETIME)
       ,SECOND) * 3600, 0)) AS charging_performance_meas,
  SUM(COALESCE(cl.total_cost_val / exr.exchange_rate, 0)) AS turnover_eur_val,
  SUM(COALESCE(cl.total_cost_val, 0)) AS turnover_local_val,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp
 FROM szd_production_core_rel.t_charge_log AS cl
  LEFT JOIN szd_production_core_rel.t_exchange_rate AS exr ON cl.invoice_curr_cd = exr.source_currency_cd AND exr.target_currency_cd
       = 'EUR' AND exr.exchange_rate_type_cd = 'IOTCHARGER' AND cl.end_tmsp BETWEEN exr.dwh_valid_from_tmsp AND exr.dwh_valid_to_tmsp
    
  LEFT JOIN szd_production_core_rel.t_charge_point_tariff AS cpt ON cl.charge_point_tariff_id = cpt.charge_point_tariff_id
   
  LEFT JOIN szd_production_core_rel.t_electro_mobility_provider AS emp ON cl.emp_party_sid = emp.party_sid
  LEFT JOIN szd_production_core.t_dim_charge_point AS cpo ON cl.charge_point_resource_item_sid = cpo.resource_item_sid
   AND cpo.dwh_valid_fg
  LEFT JOIN szd_production_core.t_dim_charger AS chg ON cl.charger_resource_item_sid = chg.resource_item_sid AND chg.dwh_valid_fg
   
  LEFT JOIN szd_production_core.t_dim_real_estate AS res ON chg.real_estate_resource_item_sid = res.resource_item_sid
   AND res.dwh_valid_fg
 WHERE cl.meter_total_meas >= 0
  AND cl.meter_total_meas < 150000
  AND TIMESTAMP_DIFF(CAST(cl.end_local_tmsp AS DATETIME), CAST(cl.start_local_tmsp AS DATETIME), SECOND) > 0
 GROUP BY report_dt,
  cl.charger_provider_system_cd,
  cl.charge_point_resource_item_sid,
  cl.charger_resource_item_sid,
  charging_station_owner_party_sid,
  real_estate_resource_item_sid,
  country_location_sid,
  division_party_sid,
  authentication_method_cd,
  charge_point_plugin_type_cd,
  charge_point_power_type_cd,
  charger_station_type_cd,
  curr_cd,
  local_curr_cd,
  dwh_created_tmsp,
  dwh_updated_tmsp);


COMMIT