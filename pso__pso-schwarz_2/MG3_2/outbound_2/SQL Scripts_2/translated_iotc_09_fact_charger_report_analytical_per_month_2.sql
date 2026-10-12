BEGIN TRANSACTION;


TRUNCATE TABLE szd_production_core.${TST_PREFIX}t_fact_charger_report_analytical_per_month_2;


INSERT INTO szd_production_core.${TST_PREFIX}t_fact_charger_report_analytical_per_month_2 (report_month, charger_provider_system_cd,
 charging_station_owner_party_sid, real_estate_resource_item_sid, country_location_sid, division_party_sid,
 charger_station_type_cd, authentication_method_cd, curr_cd, local_curr_cd, provided_power_meas, charging_process_cnt,
 charging_duration_sec_meas, charging_performance_meas, turnover_eur_val, turnover_local_val, customer_cnt,
 dwh_created_tmsp, dwh_updated_tmsp)
(SELECT CAST(ROUND(CAST(FORMAT_TIMESTAMP('%Y%m', clg.end_local_tmsp) AS BIGNUMERIC), 0) AS INTEGER) AS report_month,
  clg.charger_provider_system_cd,
  COALESCE(chg.charging_station_owner_party_sid, - 1) AS charging_station_owner_party_sid,
  COALESCE(res.resource_item_sid, - 1) AS real_estate_resource_item_sid,
  COALESCE(res.country_location_sid, - 1) AS country_location_sid,
  COALESCE(res.division_party_sid, - 1) AS division_party_sid,
  COALESCE(PWT.charging_station_type_cd, '-1') AS charging_station_type_cd,
   CASE
   WHEN UPPER(cpt.charge_point_tariff_name) LIKE 'LIDL%'
   THEN 'LIDL-PLUS'
   WHEN UPPER(cpt.charge_point_tariff_name) LIKE 'KAUFLAND%'
   THEN 'KFL-APP'
   WHEN clg.roaming_interface_cd = 'ENERGISED'
   THEN 'ICR'
   WHEN clg.roaming_interface_cd = 'COMMUNITY'
   THEN CASE
    WHEN UPPER(emp.emp_name) = 'VIRTUAL DIRECT PAYMENT PROVIDER'
    THEN 'ADHOC'
    ELSE 'RCOM'
    END
   ELSE '-1'
   END AS authentication_method_cd,
  'EUR' AS curr_cd,
  COALESCE(exr.source_currency_cd, '-1') AS local_curr_cd,
  SUM(clg.meter_total_meas / 1000) AS provided_power_meas,
  SUM(1) AS charging_process_cnt,
  SUM(TIMESTAMP_DIFF(CAST(clg.end_local_tmsp AS DATETIME), CAST(clg.start_local_tmsp AS DATETIME), SECOND)) AS
  charging_duration_sec_meas,
  SUM(clg.meter_total_meas / 1000 / TIMESTAMP_DIFF(CAST(clg.end_local_tmsp AS DATETIME), CAST(clg.start_local_tmsp AS DATETIME)
      ,SECOND) * 3600) AS charging_performance_meas,
  COALESCE(SUM(clg.total_cost_val / exr.exchange_rate), 0) AS turnover_eur_val,
  COALESCE(SUM(clg.total_cost_val), 0) AS turnover_local_val,
  COUNT(DISTINCT cap.customer_application_nr) AS customer_cnt,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp
 FROM szd_production_core_rel.t_charge_log_2 AS clg
  LEFT JOIN szd_production_core_rel.t_exchange_rate_2 AS exr ON clg.invoice_curr_cd = exr.source_currency_cd AND exr.target_currency_cd
       = 'EUR' AND exr.exchange_rate_type_cd = 'IOTCHARGER' AND clg.end_tmsp BETWEEN exr.dwh_valid_from_tmsp AND exr.dwh_valid_to_tmsp
    
  LEFT JOIN (SELECT t1.charge_point_resource_item_sid,
    t1.charge_point_plugin_type_cd,
    MAX(t1.charge_point_plugin_type_cd) OVER (PARTITION BY t1.charger_resource_item_sid RANGE BETWEEN
     UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS charging_station_type_cd
   FROM (SELECT DISTINCT cpo.resource_item_sid AS charge_point_resource_item_sid,
      cpo.charger_resource_item_sid,
      pct.power_type_cd AS charge_point_plugin_type_cd
     FROM szd_production_core_rel.t_charge_point_2 AS cpo
      INNER JOIN szd_production_core_rel.t_charge_point_connector_type_2 AS pct ON cpo.charge_point_connector_type_id =
       pct.charge_point_connector_type_id
     WHERE cpo.charger_resource_item_sid <> - 1) AS t1_2) AS PWT ON clg.charge_point_resource_item_sid = PWT.charge_point_resource_item_sid
   
  LEFT JOIN szd_production_core_rel.t_charger_2 AS chg ON clg.charger_resource_item_sid = chg.resource_item_sid AND chg.dwh_valid_fg
   
  LEFT JOIN szd_production_core_rel.t_real_estate_2 AS res ON chg.real_estate_resource_item_sid = res.resource_item_sid
   AND res.dwh_valid_fg
  LEFT JOIN szd_production_core_rel.t_charge_point_tariff_2 AS cpt ON clg.charge_point_tariff_id = cpt.charge_point_tariff_id
   
  LEFT JOIN szd_production_core_rel.t_electro_mobility_provider_2 AS emp ON clg.emp_party_sid = emp.party_sid AND emp.dwh_valid_fg
   
  LEFT JOIN szd_production_core_rel.t_customer_application_2 AS cap ON clg.customer_application_channel_sid = cap.channel_sid
     AND cap.dwh_valid_fg
 WHERE clg.meter_total_meas >= 0
  AND clg.meter_total_meas < 150000
  AND TIMESTAMP_DIFF(CAST(clg.end_local_tmsp AS DATETIME), CAST(clg.start_local_tmsp AS DATETIME), SECOND) > 0
 GROUP BY report_month,
  clg.charger_provider_system_cd,
  charging_station_owner_party_sid,
  real_estate_resource_item_sid,
  country_location_sid,
  division_party_sid,
  charging_station_type_cd,
  authentication_method_cd,
  curr_cd,
  local_curr_cd);


COMMIT