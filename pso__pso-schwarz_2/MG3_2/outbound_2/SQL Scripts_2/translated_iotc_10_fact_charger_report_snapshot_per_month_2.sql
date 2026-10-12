BEGIN TRANSACTION;


TRUNCATE TABLE szd_production_core.${TST_PREFIX}t_fact_charger_report_snapshot_per_month_2;


INSERT INTO szd_production_core.${TST_PREFIX}t_fact_charger_report_snapshot_per_month_2 (report_month, charger_provider_system_cd,
 charging_station_owner_party_sid, real_estate_resource_item_sid, country_location_sid, division_party_sid,
 charger_station_type_cd, available_charger_cnt, dwh_created_tmsp, dwh_updated_tmsp)
(SELECT mnt.cy_month,
  chg.charger_provider_system_cd,
  COALESCE(chg.charging_station_owner_party_sid, - 1) AS charging_station_owner_party_sid,
  COALESCE(res.resource_item_sid, - 1) AS real_estate_resource_item_sid,
  COALESCE(res.country_location_sid, - 1) AS country_location_sid,
  COALESCE(res.division_party_sid, - 1) AS division_party_sid,
  COALESCE(PWT.charging_station_type_cd, '-1') AS charging_station_type_cd,
  COUNT(DISTINCT chg.resource_item_sid) AS available_charger_cnt,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP()
 FROM szd_production_core_rel.t_charger_2 AS chg
  INNER JOIN szd_production_core.t_dim_cal_month_2 AS mnt ON mnt.cy_month_end_dt BETWEEN CAST(chg.dwh_valid_from_tmsp AS DATE)
   AND (CAST(chg.dwh_valid_to_tmsp AS DATE))
  LEFT JOIN szd_production_core_rel.t_real_estate_2 AS res ON chg.real_estate_resource_item_sid = res.resource_item_sid
   AND res.dwh_valid_fg
  LEFT JOIN (SELECT cpo.charger_resource_item_sid,
    MAX(pct.power_type_cd) AS charging_station_type_cd
   FROM szd_production_core_rel.t_charge_point_2 AS cpo
    INNER JOIN szd_production_core_rel.t_charge_point_connector_type_2 AS pct ON cpo.charge_point_connector_type_id = pct
     .charge_point_connector_type_id
   WHERE cpo.charger_resource_item_sid <> - 1
   GROUP BY cpo.charger_resource_item_sid) AS PWT ON chg.resource_item_sid = PWT.charger_resource_item_sid
 WHERE chg.resource_item_sid <> - 1
  AND CURRENT_DATE > mnt.cy_month_end_dt
 GROUP BY mnt.cy_month,
  chg.charger_provider_system_cd,
  charging_station_owner_party_sid,
  real_estate_resource_item_sid,
  country_location_sid,
  division_party_sid,
  charging_station_type_cd);


COMMIT