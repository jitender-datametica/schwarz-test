BEGIN TRANSACTION;

TRUNCATE TABLE   xx_db_name_zz.core.xx_tst_prefix_zzt_dim_charge_point;

INSERT INTO xx_db_name_zz.core.xx_tst_prefix_zzt_dim_charge_point (
  resource_item_sid,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  charger_provider_system_cd,
  charger_resource_item_sid,
  charge_point_plugin_type_cd,
  charge_point_plugin_type_name,
  charge_point_power_type_cd,
  charge_point_power_type_name,
  charge_point_uuid_nr,
  charge_point_connector_label_txt,
  charge_point_evse_nr,
  charge_point_ocpp_id,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_src_file_name,
  dwh_src_1_tmsp
)
SELECT
  subselect.resource_item_sid,
  subselect.dwh_valid_from_tmsp,
  subselect.dwh_valid_to_tmsp,
  current_timestamp() BETWEEN subselect.dwh_valid_from_tmsp AND subselect.dwh_valid_to_tmsp AS dwh_valid_fg,
  subselect.charger_provider_system_cd,
  subselect.charger_resource_item_sid,
  subselect.charge_point_plugin_type_cd,
  subselect.charge_point_plugin_type_name,
  subselect.charge_point_power_type_cd,
  subselect.charge_point_power_type_name,
  subselect.charge_point_uuid_nr,
  subselect.connector_label_txt,
  subselect.evse_nr,
  subselect.ocpp_id,
  subselect.dwh_created_tmsp AS dwh_created_tmsp,
  subselect.dwh_updated_tmsp AS dwh_updated_tmsp,
  subselect.dwh_src_file_name AS dwh_src_file_name,
  subselect.dwh_src_1_tmsp AS dwh_src_1_tmsp
FROM (
  SELECT
    subselect_0.resource_item_sid,
    subselect_0.dwh_valid_from_tmsp,
    DATETIME_SUB(LEAD(subselect_0.dwh_valid_from_tmsp, CAST('1' AS NUMERIC), '9999-12-31 23:59:59.999') OVER (
      PARTITION BY subselect_0.resource_item_sid
      ORDER BY IF(subselect_0.dwh_valid_from_tmsp IS NULL, 0, 1) DESC, subselect_0.dwh_valid_from_tmsp
    ), INTERVAL '1' MILLISECOND) AS dwh_valid_to_tmsp,
    subselect_0.charger_provider_system_cd,
    subselect_0.charger_resource_item_sid,
    subselect_0.charge_point_plugin_type_cd,
    subselect_0.charge_point_plugin_type_name,
    subselect_0.charge_point_power_type_cd,
    subselect_0.charge_point_power_type_name,
    subselect_0.charge_point_uuid_nr,
    subselect_0.connector_label_txt,
    subselect_0.evse_nr,
    subselect_0.ocpp_id,
    subselect_0.dwh_created_tmsp,
    subselect_0.dwh_updated_tmsp,
    subselect_0.dwh_src_file_name,
    subselect_0.dwh_src_1_tmsp
  FROM (
    SELECT
      subselect_1.resource_item_sid,
      subselect_1.dwh_valid_from_tmsp,
      subselect_1.charger_provider_system_cd,
      subselect_1.charger_resource_item_sid,
      subselect_1.charge_point_plugin_type_cd,
      subselect_1.charge_point_plugin_type_name,
      subselect_1.charge_point_power_type_cd,
      subselect_1.charge_point_power_type_name,
      subselect_1.charge_point_uuid_nr,
      subselect_1.connector_label_txt,
      subselect_1.evse_nr,
      subselect_1.ocpp_id,
      subselect_1.dwh_created_tmsp,
      subselect_1.dwh_updated_tmsp,
      subselect_1.dwh_src_file_name,
      subselect_1.dwh_src_1_tmsp,
      LAG(subselect_1.hash_nr, CAST('1' AS NUMERIC), '#') OVER (
        PARTITION BY subselect_1.resource_item_sid
        ORDER BY IF(subselect_1.dwh_valid_from_tmsp IS NULL, 0, 1) DESC, subselect_1.dwh_valid_from_tmsp
      ) <> subselect_1.hash_nr AS change_fg
    FROM (
      SELECT
        cpo.resource_item_sid,
        cpo.dwh_valid_from_tmsp,
        cpo.charger_provider_system_cd,
        cpo.charger_resource_item_sid,
        cpo.charge_point_plugin_type_cd,
        cpgt.charge_point_plugin_type_name,
        cppt.charge_point_power_type_cd,
        cppt.charge_point_power_type_name,
        cpo.charge_point_uuid_nr,
        cpo.connector_label_txt,
        cpo.evse_nr,
        cpo.ocpp_id,
        TO_HEX(
          MD5(
            CONCAT(
              coalesce(cpo.charger_provider_system_cd, '1'),
              '^',
              CAST(coalesce(cpo.charger_resource_item_sid, -CAST('1' AS NUMERIC)) AS STRING),
              '^',
              coalesce(cpo.charge_point_plugin_type_cd, '-1'),
              '^',
              coalesce(cpgt.charge_point_plugin_type_name, '#'),
              '^',
              coalesce(cppt.charge_point_power_type_cd, '-1'),
              '^',
              coalesce(cppt.charge_point_power_type_name, '#'),
              '^',
              coalesce(cpo.charge_point_uuid_nr, '#'),
              '^',
              coalesce(cpo.connector_label_txt, '#'),
              '^',
              coalesce(cpo.evse_nr, '#'),
              '^',
              CAST(coalesce(cpo.ocpp_id, -CAST('1' AS NUMERIC)) AS STRING)
            )
          )
        ) AS hash_nr,
        cpo.dwh_created_tmsp AS dwh_created_tmsp,
        greatest(cpo.dwh_updated_tmsp, cpct.dwh_updated_tmsp, cppt.dwh_updated_tmsp) AS dwh_updated_tmsp,
        cpo.dwh_src_file_name,
        cpo.dwh_src_1_tmsp
      FROM szd_production.core_rel.t_charge_point_1 AS cpo
      INNER JOIN szd_production.core_rel.t_charge_point_connector_type_1 AS cpct
        ON cpo.charge_point_connector_type_id = cpct.charge_point_connector_type_id
      INNER JOIN xx_db_name_zz.core.t_dim_charge_point_power_type_1 AS cppt
        ON cppt.charge_point_power_type_cd = cpct.power_type_cd
      INNER JOIN xx_db_name_zz.core.t_dim_charge_point_plugin_type_1 AS cpgt
        ON cpo.charge_point_plugin_type_cd = cpgt.charge_point_plugin_type_cd
    ) AS subselect_1
  ) AS subselect_0
  WHERE
    subselect_0.change_fg = TRUE
) AS subselect;

COMMIT TRANSACTION;