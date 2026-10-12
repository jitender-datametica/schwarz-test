CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_fact_charger_report_analytical_per_month (report_month,
charger_provider_system_cd, charging_station_owner_name, real_estate_nr, iso_country_cd, eu_member_fg, division_cd,
charger_station_type_cd, authentication_method_cd, charger_classification_id, turnover_local_curr_cd, turnover_local_val
, turnover_eur_val, provided_power_meas, charging_process_cnt, charging_duration_sec_meas, charging_performance_meas,
customer_cnt) AS SELECT TF1.report_month,
 TF1.charger_provider_system_cd,
 TD3.charging_station_owner_name,
 TD4.real_estate_nr,
 TD5.iso_country_cd,
 TD5.eu_member_fg,
 TD6.division_cd,
 TF1.charger_station_type_cd,
 TF1.authentication_method_cd,
 TF1.charger_classification_id,
 TF1.local_curr_cd AS turnover_local_curr_cd,
 TF1.turnover_local_val,
 TF1.turnover_eur_val,
 TF1.provided_power_meas,
 TF1.charging_process_cnt,
 TF1.charging_duration_sec_meas,
 TF1.charging_performance_meas,
 TF1.customer_cnt
FROM szd_core.t_fact_charger_report_analytical_per_month AS TF1
 INNER JOIN szd_core.t_dim_charging_station_owner AS TD3 ON TF1.charging_station_owner_party_sid = TD3.party_sid AND TD3
  .dwh_valid_fg
 INNER JOIN szd_core.t_dim_real_estate AS TD4 ON TF1.real_estate_resource_item_sid = TD4.resource_item_sid AND TD4.dwh_valid_fg
  
 INNER JOIN szd_core.t_dim_country_political AS TD5 ON TF1.country_location_sid = TD5.location_sid AND TD5.dwh_valid_fg
 INNER JOIN szd_core.t_dim_division AS TD6 ON TF1.division_party_sid = TD6.party_sid AND TD6.dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP)
   
WHERE TF1.relevance_fg;