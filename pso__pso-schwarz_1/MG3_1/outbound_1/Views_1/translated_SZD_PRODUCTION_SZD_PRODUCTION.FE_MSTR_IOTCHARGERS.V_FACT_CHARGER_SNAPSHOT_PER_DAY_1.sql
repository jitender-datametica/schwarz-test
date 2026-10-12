CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_fact_charger_snapshot_per_day_1 (report_dt,
charger_provider_system_cd, charger_uuid_nr, charging_station_owner_name, real_estate_nr, iso_country_cd, eu_member_fg,
division_cd, charger_station_type_cd, charger_classification_id, available_charger_cnt) AS SELECT tf1.report_dt,
 tf1.charger_provider_system_cd,
 td2.charger_uuid_nr,
 td3.charging_station_owner_name,
 td4.real_estate_nr,
 td5.iso_country_cd,
 td5.eu_member_fg,
 td6.division_cd,
 tf1.charger_station_type_cd,
 tf1.charger_classification_id,
 tf1.available_charger_cnt
FROM szd_production_core.t_fact_charger_snapshot_per_day_1 AS tf1
 INNER JOIN szd_production_core.t_dim_charger_1 AS td2 ON tf1.charger_resource_item_sid = td2.resource_item_sid AND td2.dwh_valid_fg
  
 INNER JOIN szd_production_core.t_dim_charging_station_owner_1 AS td3 ON tf1.charging_station_owner_party_sid = td3.party_sid
    AND td3.dwh_valid_fg
 INNER JOIN szd_production_core.t_dim_real_estate_1 AS td4 ON tf1.real_estate_resource_item_sid = td4.resource_item_sid
  AND td4.dwh_valid_fg
 INNER JOIN szd_production_core.t_dim_country_political_1 AS td5 ON tf1.country_location_sid = td5.location_sid AND td5.dwh_valid_fg
  
 INNER JOIN szd_production_core.t_dim_division_1 AS td6 ON tf1.division_party_sid = td6.party_sid AND td6.dwh_valid_to_tmsp
    >= CAST('9999-12-31' AS TIMESTAMP);