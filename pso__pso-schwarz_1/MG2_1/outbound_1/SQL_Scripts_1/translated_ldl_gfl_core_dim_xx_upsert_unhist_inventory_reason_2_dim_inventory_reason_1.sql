INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
        inv_reason_id,
        inv_reason_descr,
        inv_reason_descr_de,
        inv_reason_descr_en,
        dwh_load_id,
        dwh_node_cd,
        tf_error_fg,
        error_descr,
        record_id,
        filename
    )
SELECT
    de.inv_reason_id,
    de.inv_reason_descr,
    de.inv_reason_descr AS inv_reason_descr_de,
    COALESCE(en.inv_reason_descr, 'Unknown') AS inv_reason_descr_en,
    ${LOAD_ID} AS dwh_load_id,
    de.dwh_node_cd AS dwh_node_cd,
    0 AS tf_error_fg,
    '' AS error_descr,
    0 AS record_id,
    'core_rel' AS filename
FROM core_rel.t_inventory_reason_1 AS de
    LEFT OUTER JOIN core_rel.t_inventory_reason_1 AS en 
    ON de.inv_reason_id = en.inv_reason_id
    AND en.lang_cd = 'EN'
WHERE de.lang_cd = 'DE'
UNION DISTINCT
SELECT
    - 1,
    'Unbekannt',
    'Unbekannt',
    'Unknown',
    ${LOAD_ID} AS dwh_load_id,
    'MANUAL' AS dwh_node_cd,
    NUMERIC '0' AS tf_error_fg,
    '' AS error_descr,
    NUMERIC '0' AS record_id,
    'core_rel' AS filename;