CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_fact_charge_point_analytical_per_day_2 (report_dt,
charger_provider_system_cd, charge_point_uuid_nr, charger_uuid_nr, charging_station_owner_name, real_estate_nr,
iso_country_cd, eu_member_fg, division_cd, authentication_method_cd, charge_point_plugin_type_cd,
charge_point_power_type_cd, charger_station_type_cd, charger_classification_id, turnover_local_curr_cd,
turnover_local_val, turnover_eur_val, provided_power_meas, charging_process_cnt, charging_duration_sec_meas,
charging_performance_meas) AS SELECT tf1.report_dt,
 tf1.charger_provider_system_cd,
 td1.charge_point_uuid_nr,
 td2.charger_uuid_nr,
 td3.charging_station_owner_name,
 td4.real_estate_nr,
 td5.iso_country_cd,
 td5.eu_member_fg,
 td6.division_cd,
 tf1.authentication_method_cd,
 tf1.charge_point_plugin_type_cd,
 tf1.charge_point_power_type_cd,
 tf1.charger_station_type_cd,
 tf1.charger_classification_id,
 tf1.local_curr_cd AS turnover_local_curr_cd,
 tf1.turnover_local_val,
 tf1.turnover_eur_val,
 tf1.provided_power_meas,
 tf1.charging_process_cnt,
 tf1.charging_duration_sec_meas,
 tf1.charging_performance_meas
FROM szd_production_core.t_fact_charge_point_analytical_per_day_2 AS tf1
 INNER JOIN szd_production_core.t_dim_charge_point_2 AS td1 ON tf1.charge_point_resource_item_sid = td1.resource_item_sid
  AND td1.dwh_valid_fg
 INNER JOIN szd_production_core.t_dim_charger_2 AS td2 ON tf1.charger_resource_item_sid = td2.resource_item_sid AND td2.dwh_valid_fg
  
 INNER JOIN szd_production_core.t_dim_charging_station_owner_2 AS td3 ON tf1.charging_station_owner_party_sid = td3.party_sid
    AND td3.dwh_valid_fg
 INNER JOIN szd_production_core.t_dim_real_estate_2 AS td4 ON tf1.real_estate_resource_item_sid = td4.resource_item_sid
  AND td4.dwh_valid_fg
 INNER JOIN szd_production_core.t_dim_country_political_2 AS td5 ON tf1.country_location_sid = td5.location_sid AND td5.dwh_valid_fg
  
 INNER JOIN szd_production_core.t_dim_division_2 AS td6 ON tf1.division_party_sid = td6.party_sid AND td6.dwh_valid_to_tmsp
    >= CAST('9999-12-31' AS TIMESTAMP);