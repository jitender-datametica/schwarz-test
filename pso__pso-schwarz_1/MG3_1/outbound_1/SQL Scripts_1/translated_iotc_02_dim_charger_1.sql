BEGIN TRANSACTION;


TRUNCATE TABLE core.`${TST_PREFIX}T_DIM_CHARGER_1`;


INSERT INTO core.`${TST_PREFIX}T_DIM_CHARGER_1` (resource_item_sid,
 dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, charger_provider_system_cd, charging_station_owner_party_sid,
 real_estate_resource_item_sid, charger_station_type_cd, charger_station_type_name, charger_uuid_nr, charger_label_nr,
 public_display_name, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, dwh_src_1_tmsp)
(SELECT t1.resource_item_sid,
  t1.dwh_valid_from_tmsp,
  TIMESTAMP_SUB(LEAD(t1.dwh_valid_from_tmsp, 1, CAST('9999-12-31 23:59:59.999' AS TIMESTAMP)) OVER
    (PARTITION BY t1.resource_item_sid ORDER BY t1.dwh_valid_from_tmsp IS NULL, t1.dwh_valid_from_tmsp), INTERVAL 1
   MILLISECOND) AS dwh_valid_to_tmsp,
   CURRENT_TIMESTAMP() BETWEEN t1.dwh_valid_from_tmsp AND (TIMESTAMP_SUB(LEAD(t1.dwh_valid_from_tmsp, 1, CAST('9999-12-31 23:59:59.999' AS TIMESTAMP)
      ) OVER (PARTITION BY t1.resource_item_sid ORDER BY t1.dwh_valid_from_tmsp IS NULL, t1.dwh_valid_from_tmsp),
     INTERVAL 1 MILLISECOND)) AS dwh_valid_fg,
  t1.charger_provider_system_cd,
  t1.charging_station_owner_party_sid,
  t1.real_estate_resource_item_sid,
  t1.charger_station_type_cd,
  t1.charger_station_type_name,
  t1.charger_uuid_nr,
  t1.label_nr,
  t1.public_display_name,
  t1.dwh_created_tmsp,
  t1.dwh_updated_tmsp,
  t1.dwh_src_file_name,
  t1.dwh_src_1_tmsp
 FROM (SELECT c.resource_item_sid,
    c.dwh_valid_from_tmsp,
    c.charger_provider_system_cd,
    COALESCE(c.charging_station_owner_party_sid, - 1) AS charging_station_owner_party_sid,
    COALESCE(c.real_estate_resource_item_sid, - 1) AS real_estate_resource_item_sid,
    COALESCE(CPO.power_type_cd, '-1') AS charger_station_type_cd,
    COALESCE(cst.charger_station_type_name, 'Unbekannt') AS charger_station_type_name,
    c.charger_uuid_nr,
    c.label_nr,
    COALESCE(c.public_display_name, 'Unbekannt') AS public_display_name,
    c.dwh_created_tmsp,
    c.dwh_updated_tmsp,
    c.dwh_src_file_name,
    c.dwh_src_1_tmsp,
      (LAG(TO_HEX(MD5(COALESCE(c.charger_provider_system_cd, '-1') || '^' || CAST(COALESCE(c.real_estate_resource_item_sid, - 1) AS STRING)
                       || '^' || COALESCE(CPO.power_type_cd, '-1') || '^' || COALESCE(cst.charger_station_type_name, '#'
                   ) || '^' || COALESCE(c.charger_uuid_nr, '#') || '^' || COALESCE(c.label_nr, '#') || '^' || CAST(COALESCE(c.charging_station_owner_party_sid, - 1) AS STRING)
             || '^' || COALESCE(c.public_display_name, '#'))), 1, '#') OVER (PARTITION BY c.resource_item_sid ORDER BY c
         .dwh_valid_from_tmsp IS NULL, c.dwh_valid_from_tmsp)) <> TO_HEX(MD5(COALESCE(c.charger_provider_system_cd, '-1'
                      ) || '^' || CAST(COALESCE(c.real_estate_resource_item_sid, - 1) AS STRING) || '^' || COALESCE(CPO
                   .power_type_cd, '-1') || '^' || COALESCE(cst.charger_station_type_name, '#') || '^' || COALESCE(c.charger_uuid_nr
               , '#') || '^' || COALESCE(c.label_nr, '#') || '^' || CAST(COALESCE(c.charging_station_owner_party_sid, - 1) AS STRING)
           || '^' || COALESCE(c.public_display_name, '#'))) AS change_fg
   FROM szd_production_core_rel.t_charger_1 AS c
    LEFT JOIN (SELECT cpo.charger_resource_item_sid,
      MAX(cpct.power_type_cd) AS power_type_cd
     FROM szd_production_core_rel.t_charge_point_1 AS cpo
      INNER JOIN szd_production_core_rel.t_charge_point_connector_type_1 AS cpct ON cpo.charge_point_connector_type_id =
       cpct.charge_point_connector_type_id
     GROUP BY cpo.charger_resource_item_sid) AS CPO ON c.resource_item_sid = CPO.charger_resource_item_sid
    LEFT JOIN szd_production_core.t_dim_charger_station_type_1 AS cst ON CPO.power_type_cd = cst.charger_station_type_cd
   QUALIFY (LAG(TO_HEX(MD5(COALESCE(c.charger_provider_system_cd, '-1') || '^' || CAST(COALESCE(c.real_estate_resource_item_sid, - 1) AS STRING)
                       || '^' || COALESCE(CPO.power_type_cd, '-1') || '^' || COALESCE(cst.charger_station_type_name, '#'
                   ) || '^' || COALESCE(c.charger_uuid_nr, '#') || '^' || COALESCE(c.label_nr, '#') || '^' || CAST(COALESCE(c.charging_station_owner_party_sid, - 1) AS STRING)
             || '^' || COALESCE(c.public_display_name, '#'))), 1, '#') OVER (PARTITION BY c.resource_item_sid ORDER BY c
         .dwh_valid_from_tmsp IS NULL, c.dwh_valid_from_tmsp)) <> TO_HEX(MD5(COALESCE(c.charger_provider_system_cd, '-1'
                      ) || '^' || CAST(COALESCE(c.real_estate_resource_item_sid, - 1) AS STRING) || '^' || COALESCE(CPO
                   .power_type_cd, '-1') || '^' || COALESCE(cst.charger_station_type_name, '#') || '^' || COALESCE(c.charger_uuid_nr
               , '#') || '^' || COALESCE(c.label_nr, '#') || '^' || CAST(COALESCE(c.charging_station_owner_party_sid, - 1) AS STRING)
           || '^' || COALESCE(c.public_display_name, '#')))) AS t1_1);


COMMIT TRANSACTION;