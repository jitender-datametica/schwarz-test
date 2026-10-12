INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
    logistic_variant_type_cd,
    logistic_variant_type_descr,
    logistic_variant_type_descr_de,
    logistic_variant_type_descr_en,
    dwh_load_id,
    dwh_node_cd,
    tf_error_fg,
    error_descr,
    record_id,
    filename
)
SELECT
    logistic_variant_type_cd,
    COALESCE(MAX(CASE WHEN lang_cd = 'DE' THEN logistic_variant_type_descr END), 'Unbekannt') AS logistic_variant_type_descr,
    COALESCE(MAX(CASE WHEN lang_cd = 'DE' THEN logistic_variant_type_descr END), 'Unbekannt') AS logistic_variant_type_descr_de,
    COALESCE(MAX(CASE WHEN lang_cd = 'EN' THEN logistic_variant_type_descr END), 'Unknown') AS logistic_variant_type_descr_en,
    ${LOAD_ID} AS dwh_load_id,
    'CORE_REL' AS dwh_node_cd,
    NUMERIC '0' AS tf_error_fg,
    '' AS error_descr,
    NUMERIC '0' AS record_id,
    'core_rel' AS filename
FROM core_rel.t_logistic_variant_type
GROUP BY t_logistic_variant_type.logistic_variant_type_cd

UNION DISTINCT

SELECT
    '@',
    'Unbekannt',
    'Unbekannt',
    'Unknown',
    ${LOAD_ID} AS dwh_load_id,
    'CORE_REL' AS dwh_node_cd,
    NUMERIC '0' AS tf_error_fg,
    '' AS error_descr,
    NUMERIC '0' AS record_id,
    'core_rel' AS filename
;
