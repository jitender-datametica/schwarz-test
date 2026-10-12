INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
    pallet_type_cd,
    pallet_space_factor,
    pallet_type_descr,
    pallet_type_descr_de,
    pallet_type_descr_en,
    dwh_load_id,
    dwh_node_cd,
    tf_error_fg,
    error_descr,
    record_id,
    filename
)
SELECT
    pallet_type_cd,
    ANY_VALUE(pallet_space_factor) AS pallet_space_factor,
    COALESCE(ANY_VALUE(CASE WHEN lang_cd = 'DE' THEN pallet_type_descr END), 'Unbekannt') AS pallet_type_descr,
    COALESCE(ANY_VALUE(CASE WHEN lang_cd = 'DE' THEN pallet_type_descr END), 'Unbekannt') AS pallet_type_descr_de,
    COALESCE(ANY_VALUE(CASE WHEN lang_cd = 'EN' THEN pallet_type_descr END), 'Unknown') AS pallet_type_descr_en,
    ${LOAD_ID} AS dwh_load_id,
    'CORE_REL' AS dwh_node_cd,
    0 AS tf_error_fg,
    '' AS error_descr,
    0 AS record_id,
    'core_rel' AS filename
FROM core_rel.t_pallet_type_2
GROUP BY t_pallet_type.pallet_type_cd
UNION DISTINCT
SELECT
    '@' AS pallet_type_cd,
    NULL AS pallet_space_factor,
    'Unbekannt' AS pallet_type_descr,
    'Unbekannt' AS pallet_type_descr_de,
    'Unknown' AS pallet_type_descr_en,
    ${LOAD_ID} AS dwh_load_id,
    'CORE_REL' AS dwh_node_cd,
    0 AS tf_error_fg,
    '' AS error_descr,
    0 AS record_id,
    'core_rel' AS filename
;
