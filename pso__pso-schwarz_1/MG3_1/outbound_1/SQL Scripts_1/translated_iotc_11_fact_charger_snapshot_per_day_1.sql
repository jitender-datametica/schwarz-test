BEGIN TRANSACTION;


TRUNCATE TABLE szd_production_core.${TST_PREFIX}t_fact_charger_snapshot_per_day_1;


INSERT INTO szd_production_core.${TST_PREFIX}t_fact_charger_snapshot_per_day_1 (report_dt, charger_provider_system_cd,
 charger_resource_item_sid, charging_station_owner_party_sid, real_estate_resource_item_sid, country_location_sid,
 division_party_sid, charger_station_type_cd, available_charger_cnt, dwh_created_tmsp, dwh_updated_tmsp)
WITH timeframe AS (SELECT cal_dt
   FROM szd_production_core.t_dim_cal_day_1 AS c
   WHERE cal_dt BETWEEN DATE '2023-01-01' AND (CURRENT_DATE)) (SELECT TF.cal_dt AS report_dt,
    COALESCE(chg.charger_provider_system_cd, '-1') AS charger_provider_system_cd,
    COALESCE(chg.resource_item_sid, - 1) AS charger_resource_item_sid,
    COALESCE(chg.charging_station_owner_party_sid, - 1) AS charging_station_owner_party_sid,
    COALESCE(chg.real_estate_resource_item_sid, - 1) AS real_estate_resource_item_sid,
    COALESCE(res.country_location_sid, - 1) AS country_location_sid,
    COALESCE(res.division_party_sid, - 1) AS division_party_sid,
    COALESCE(chg.charger_station_type_cd, '-1') AS charger_station_type_cd,
     CASE
     WHEN chg.resource_item_sid IS NOT NULL
     THEN 1
     ELSE 0
     END AS available_cnt,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp
   FROM timeframe AS TF
    LEFT JOIN szd_production_core.t_dim_charger_1 AS chg ON TF.cal_dt BETWEEN CAST(chg.dwh_valid_from_tmsp AS DATE) AND (CAST(chg.dwh_valid_to_tmsp AS DATE)
       ) AND chg.resource_item_sid <> - 1
    LEFT JOIN szd_production_core.t_dim_real_estate_1 AS res ON chg.real_estate_resource_item_sid = res.resource_item_sid
     AND TF.cal_dt BETWEEN CAST(res.dwh_valid_from_tmsp AS DATE) AND (CAST(res.dwh_valid_to_tmsp AS DATE)));


COMMIT