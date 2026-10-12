INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
        brand_type_cd,
        brand_type_descr,
        brand_type_descr_en,
        brand_type_descr_de,
        dwh_load_id,
        dwh_node_cd,
        tf_error_fg,
        error_descr,
        record_id,
        filename
    )
SELECT
    t_brand_type.brand_type_cd,
    MAX(CASE WHEN t_brand_type.lang_cd = 'DE' THEN t_brand_type.brand_type_descr ELSE '' END) AS brand_type_descr,
    MAX(CASE WHEN t_brand_type.lang_cd = 'EN' THEN MAX( CASE WHEN t_brand_type.lang_cd = 'DE' THEN t_brand_type.brand_type_descr ELSE '' END) ELSE '' END ) AS brand_type_descr_en,
    MAX(CASE WHEN t_brand_type.lang_cd = 'DE' THEN MAX( CASE WHEN t_brand_type.lang_cd = 'DE' THEN t_brand_type.brand_type_descr ELSE '' END) ELSE '' END) AS brand_type_descr_de,
    t_brand_type.${load_id} AS dwh_load_id,
    t_brand_type.dwh_node_cd AS dwh_node_cd,
    0 AS tf_error_fg,
    '' AS error_descr,
    0 AS record_id,
    'core_rel' AS filename
FROM
    core_rel.t_brand_type_2
GROUP BY
    brand_type_cd,
    dwh_load_id,
    dwh_node_cd,
    tf_error_fg,
    error_descr,
    record_id,
    filename
UNION DISTINCT
SELECT
    '@',
    'Unbekannt',
    'Unbekannt',
    'Unknown',
    ${load_id} AS dwh_load_id,
    'MANUAL' AS dwh_node_cd,
    NUMERIC '0' AS tf_error_fg,
    '' AS error_descr,
    NUMERIC '0' AS record_id,
    'core_rel' AS filename;