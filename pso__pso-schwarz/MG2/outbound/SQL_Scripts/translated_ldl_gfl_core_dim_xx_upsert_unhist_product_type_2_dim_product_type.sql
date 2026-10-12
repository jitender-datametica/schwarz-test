INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA} (
    prod_type_cd,
    prod_type_descr,
    prod_type_descr_de,
    prod_type_descr_en,
    dwh_load_id,
    dwh_node_cd,
    tf_error_fg,
    error_descr,
    record_id,
    filename
)
SELECT
    prod_type_cd,
    MAX(CASE WHEN lang_cd = 'DE' THEN prod_type_descr ELSE '' END) AS prod_type_descr,
    MAX(CASE WHEN lang_cd = 'DE' THEN prod_type_descr ELSE '' END) AS prod_type_descr_de,
    MAX(CASE WHEN lang_cd = 'EN' THEN prod_type_descr ELSE '' END) AS prod_type_descr_en,
    ${LOAD_ID} AS dwh_load_id,
    dwh_node_cd AS dwh_node_cd,
    0 AS tf_error_fg,
    '' AS error_descr,
    0 AS record_id,
    'core_rel' AS filename
FROM core_rel.t_product_type
GROUP BY 
    prod_type_cd,
    dwh_load_id,
    dwh_node_cd,
    tf_error_fg,
    error_descr,
    record_id,
    filename;
