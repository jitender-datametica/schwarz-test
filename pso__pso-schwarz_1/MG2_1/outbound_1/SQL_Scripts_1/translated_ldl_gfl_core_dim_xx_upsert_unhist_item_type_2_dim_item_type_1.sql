INSERT INTO   ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
        item_type_cd,
        item_type_descr,
        item_type_descr_de,
        item_type_descr_en,
        dwh_load_id,
        dwh_node_cd,
        tf_error_fg,
        error_descr,
        record_id,
        filename
    )
SELECT
    de.item_type_cd,
    de.item_type_descr,
    de.item_type_descr AS item_type_descr_de,
    COALESCE(en.item_type_descr, 'unknown') AS item_type_descr_en,
    ${LOAD_ID} AS dwh_load_id,
    'MANUAL' AS dwh_node_cd,
    NUMERIC '0' AS tf_error_fg,
    '' AS error_descr,
    NUMERIC '0' AS record_id,
    'core_rel' AS filename
FROM
    core_rel.t_item_type_1 AS de
    LEFT OUTER JOIN core_rel.t_item_type_1 AS en 
    ON de.item_type_cd = en.item_type_cd
    AND en.lang_cd = 'EN'
WHERE de.lang_cd = 'DE'
UNION DISTINCT
SELECT
    '@',
    'unbekannt',
    'unbekannt',
    'unknown',
    ${LOAD_ID} AS dwh_load_id,
    'MANUAL' AS dwh_node_cd,
    NUMERIC '0' AS tf_error_fg,
    '' AS error_descr,
    NUMERIC '0' AS record_id,
    'core_rel' AS filename;