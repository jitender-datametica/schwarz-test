CREATE OR REPLACE VIEW szd_fe_mstr_iotchargers.v_fact_charger_snapshot_per_day_1 (report_dt, charger_provider_system_cd,
charger_uuid_nr, charging_station_owner_name, real_estate_nr, iso_country_cd, eu_member_fg, division_cd,
charger_station_type_cd, charger_classification_id, available_charger_cnt) AS SELECT TF1.report_dt,
 TF1.charger_provider_system_cd,
 TD2.charger_uuid_nr,
 TD3.charging_station_owner_name,
 TD4.real_estate_nr,
 TD5.iso_country_cd,
 TD5.eu_member_fg,
 TD6.division_cd,
 TF1.charger_station_type_cd,
 TF1.charger_classification_id,
 TF1.available_charger_cnt
FROM szd_core.t_fact_charger_snapshot_per_day_1 AS TF1
 INNER JOIN szd_core.t_dim_charger_1 AS TD2 ON TF1.charger_resource_item_sid = TD2.resource_item_sid AND TD2.dwh_valid_fg
 INNER JOIN szd_core.t_dim_charging_station_owner_1 AS TD3 ON TF1.charging_station_owner_party_sid = TD3.party_sid AND TD3
  .dwh_valid_fg
 INNER JOIN szd_core.t_dim_real_estate_1 AS TD4 ON TF1.real_estate_resource_item_sid = TD4.resource_item_sid AND TD4.dwh_valid_fg
  
 INNER JOIN szd_core.t_dim_country_political_1 AS TD5 ON TF1.country_location_sid = TD5.location_sid AND TD5.dwh_valid_fg
 INNER JOIN szd_core.t_dim_division_1 AS TD6 ON TF1.division_party_sid = TD6.party_sid AND TD6.dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP);