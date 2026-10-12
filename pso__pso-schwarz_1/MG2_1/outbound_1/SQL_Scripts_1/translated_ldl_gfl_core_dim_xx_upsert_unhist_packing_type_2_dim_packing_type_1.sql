INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
    packing_type_cd,
    packing_type_descr,
    packing_type_descr_en,
    packing_type_descr_de,
    dwh_load_id,
    dwh_node_cd,
    tf_error_fg,
    error_descr,
    record_id,
    filename
)
SELECT
    packing_type_cd,
    COALESCE(MAX(CASE WHEN lang_cd = 'DE' THEN packing_type_descr END), '') AS packing_type_descr,
    COALESCE(MAX(CASE WHEN lang_cd = 'EN' THEN packing_type_descr END), '') AS packing_type_descr_en,
    COALESCE(MAX(CASE WHEN lang_cd = 'DE' THEN packing_type_descr END), '') AS packing_type_descr_de,
    ${LOAD_ID} AS dwh_load_id,
    dwh_node_cd AS dwh_node_cd,
    0 AS tf_error_fg,
    '' AS error_descr,
    0 AS record_id,
    'core_rel' AS filename
FROM core_rel.t_packing_type_1
GROUP BY 
 packing_type_cd,
 dwh_load_id,
 dwh_node_cd,
 tf_error_fg,
 error_descr,
 record_id,
 filename;
;
