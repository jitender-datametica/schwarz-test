BEGIN TRANSACTION;


TRUNCATE TABLE szd_production_core.${TST_PREFIX}t_fact_charge_point_snapshot_per_day;


INSERT INTO szd_production_core.${TST_PREFIX}t_fact_charge_point_snapshot_per_day (report_dt, charger_provider_system_cd,
 charge_point_resource_item_sid, charger_resource_item_sid, charging_station_owner_party_sid,
 real_estate_resource_item_sid, country_location_sid, division_party_sid, charge_point_plugin_type_cd,
 charge_point_power_type_cd, charger_station_type_cd, available_charge_point_cnt, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT DISTINCT TF.cal_dt AS report_dt,
  COALESCE(cpo.charger_provider_system_cd, '-1') AS charger_provider_system_cd,
  COALESCE(cpo.resource_item_sid, - 1) AS charge_point_resource_item,
  COALESCE(cpo.charger_resource_item_sid, - 1) AS charger_resource_item_sid,
  COALESCE(chg.charging_station_owner_party_sid, - 1) AS charging_station_owner_party_sid,
  COALESCE(chg.real_estate_resource_item_sid, - 1) AS real_estate_resource_item_sid,
  COALESCE(res.country_location_sid, - 1) AS country_location_sid,
  COALESCE(res.division_party_sid, - 1) AS division_party_sid,
  COALESCE(cpo.charge_point_plugin_type_cd, '-1') AS charge_point_plugin_type_cd,
  COALESCE(cpo.charge_point_power_type_cd, '-1') AS charge_point_power_type_cd,
  COALESCE(chg.charger_station_type_cd, '-1') AS charger_station_type_cd,
   CASE
   WHEN cpo.resource_item_sid IS NOT NULL
   THEN 1
   ELSE 0
   END AS available_charge_point_cnt,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp
 FROM (timeframe AS (SELECT cal_dt
    FROM szd_production_core.t_dim_cal_day AS c
    WHERE cal_dt BETWEEN DATE '2023-01-01' AND (CURRENT_DATE))) AS TF
  LEFT JOIN szd_production_core.t_dim_charge_point AS cpo ON TF.cal_dt BETWEEN CAST(cpo.dwh_valid_from_tmsp AS DATE) AND
     (CAST(cpo.dwh_valid_to_tmsp AS DATE)) AND cpo.resource_item_sid <> - 1
  LEFT JOIN szd_production_core.t_dim_charger AS chg ON cpo.charger_resource_item_sid = chg.resource_item_sid AND TF.cal_dt
    BETWEEN CAST(chg.dwh_valid_from_tmsp AS DATE) AND (CAST(chg.dwh_valid_to_tmsp AS DATE))
  LEFT JOIN szd_production_core.t_dim_real_estate AS res ON chg.real_estate_resource_item_sid = res.resource_item_sid
   AND TF.cal_dt BETWEEN CAST(res.dwh_valid_from_tmsp AS DATE) AND (CAST(res.dwh_valid_to_tmsp AS DATE)));


COMMIT