BEGIN TRANSACTION;


TRUNCATE TABLE szd_production_core.${TST_PREFIX}t_fact_charge_log_snapshot_per_day_2;


INSERT INTO szd_production_core.${TST_PREFIX}t_fact_charge_log_snapshot_per_day_2 (report_dt, charger_provider_system_cd,
 charger_resource_item_sid, charge_point_resource_item_sid, charging_station_owner_party_sid,
 real_estate_resource_item_sid, country_location_sid, division_party_sid, authentication_method_cd,
 charge_point_plugin_type_cd, charge_point_power_type_cd, charger_station_type_cd, active_charger_cnt,
 active_charge_point_cnt, dwh_created_tmsp, dwh_updated_tmsp)
WITH timeframe AS (SELECT cal_dt
   FROM szd_production_core.t_dim_cal_day_2 AS c
   WHERE cal_dt BETWEEN DATE '2023-01-01' AND (CURRENT_DATE)) (SELECT TF.cal_dt AS report_dt,
    COALESCE(cl.charger_provider_system_cd, '-1') AS charger_provider_system_cd,
    COALESCE(cl.charger_resource_item_sid, - 1) AS charger_resource_item_sid,
    COALESCE(cl.charge_point_resource_item_sid, - 1) AS charge_point_resource_item_sid,
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
     END AS authentication_method,
    COALESCE(cpo.charge_point_plugin_type_cd, '-1') AS charge_point_plugin_type_cd,
    COALESCE(cpo.charge_point_power_type_cd, '-1') AS charge_point_power_type_cd,
    COALESCE(chg.charger_station_type_cd, '-1') AS charger_station_type_cd,
     CASE
     WHEN NULLIF(cl.charger_resource_item_sid, - 1) IS NOT NULL
     THEN 1
     ELSE 0
     END AS active_charger_cnt,
     CASE
     WHEN NULLIF(cl.charge_point_resource_item_sid, - 1) IS NOT NULL
     THEN 1
     ELSE 0
     END AS active_charge_point_cnt,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp
   FROM timeframe AS TF
    LEFT JOIN szd_production_core_rel.t_charge_log_2 AS cl ON DATE(cl.start_local_tmsp) = TF.cal_dt AND (cl.meter_total_meas
          >= 0 AND cl.meter_total_meas < 150000) AND TIMESTAMP_DIFF(CAST(cl.end_local_tmsp AS DATETIME), CAST(cl.start_local_tmsp AS DATETIME)
       ,SECOND) > 0
    LEFT JOIN szd_production_core_rel.t_charge_point_tariff_2 AS cpt ON cl.charge_point_tariff_id = cpt.charge_point_tariff_id
     
    LEFT JOIN szd_production_core_rel.t_electro_mobility_provider_2 AS emp ON cl.emp_party_sid = emp.party_sid
    LEFT JOIN szd_production_core.t_dim_charger_2 AS chg ON cl.charger_resource_item_sid = chg.resource_item_sid AND TF.cal_dt
      BETWEEN CAST(chg.dwh_valid_from_tmsp AS DATE) AND (CAST(chg.dwh_valid_to_tmsp AS DATE))
    LEFT JOIN szd_production_core.t_dim_real_estate_2 AS res ON chg.real_estate_resource_item_sid = res.resource_item_sid
     AND TF.cal_dt BETWEEN CAST(res.dwh_valid_from_tmsp AS DATE) AND (CAST(res.dwh_valid_to_tmsp AS DATE))
    LEFT JOIN szd_production_core.t_dim_charge_point_2 AS cpo ON cl.charge_point_resource_item_sid = cpo.resource_item_sid
       AND TF.cal_dt BETWEEN CAST(cpo.dwh_valid_from_tmsp AS DATE) AND (CAST(cpo.dwh_valid_to_tmsp AS DATE))
   GROUP BY report_dt,
    charger_provider_system_cd,
    charger_resource_item_sid,
    charge_point_resource_item_sid,
    charging_station_owner_party_sid,
    real_estate_resource_item_sid,
    country_location_sid,
    division_party_sid,
    charge_point_plugin_type_cd,
    charge_point_power_type_cd,
    charger_station_type_cd,
    authentication_method,
    active_charger_cnt,
    active_charge_point_cnt,
    dwh_created_tmsp,
    dwh_updated_tmsp);


COMMIT