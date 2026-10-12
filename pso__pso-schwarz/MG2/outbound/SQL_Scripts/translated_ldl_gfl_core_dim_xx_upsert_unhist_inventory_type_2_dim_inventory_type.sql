INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
    inv_type_cd,
    inv_type_descr,
    inv_type_descr_de,
    inv_type_descr_en,
    dwh_load_id,
    dwh_node_cd,
    tf_error_fg,
    error_descr,
    record_id,
    filename
  )
SELECT
  de.inv_type_cd,
  de.inv_type_descr,
  de.inv_type_descr AS inv_type_descr_de,
  COALESCE(en.inv_type_descr, 'Unknown') AS inv_type_descr_en,
  ${LOAD_ID} AS dwh_load_id,
  de.dwh_node_cd,
  0 AS tf_error_fg,
  '' AS error_descr,
  0 AS record_id,
  'core_rel' AS filename
FROM
  core_rel.t_inventory_type AS de
  LEFT OUTER JOIN core_rel.t_inventory_type AS en 
  ON de.inv_type_cd = en.inv_type_cd
  AND en.lang_cd = 'EN'
WHERE de.lang_cd = 'DE'
UNION DISTINCT
SELECT
  '@',
  'Unbekannt',
  'Unbekannt',
  'Unknown',
  ${LOAD_ID} AS dwh_load_id,
  'MANUAL' AS dwh_node_cd,
  0 AS tf_error_fg,
  '' AS error_descr,
  0 AS record_id,
  'core_rel' AS filename;