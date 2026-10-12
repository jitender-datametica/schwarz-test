INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
        dispatch_grp_nr,
        country_org_sid,
        dispatch_grp_descr,
        dispatch_grp_descr_de,
        dispatch_grp_descr_en,
        dwh_load_id,
        dwh_node_cd,
        tf_error_fg,
        error_descr,
        record_id,
        filename
    )
SELECT
    de.dispatch_grp_nr,
    de.int_org_sid AS country_org_sid,
    CASE WHEN de.lang_cd = 'DE' THEN de.dispatch_grp_descr ELSE 'unbekannt' END AS dispatch_grp_descr,
    CASE WHEN en.lang_cd = 'EN' THEN en.dispatch_grp_descr ELSE 'unknown' END AS dispatch_grp_descr_en,
    CASE WHEN de.lang_cd = 'DE' THEN de.dispatch_grp_descr ELSE 'unbekannt' END AS dispatch_grp_descr_de,
    ${load_id} AS dwh_load_id,
    de.dwh_node_cd AS dwh_node_cd,
    0 AS tf_error_fg,
    '' AS error_descr,
    0 AS record_id,
    'core_rel' AS filename
FROM
    (
        SELECT
            *
        FROM core_rel.t_dispatch_group_2
        WHERE t_dispatch_group.lang_cd = 'DE'
    ) AS de
    LEFT OUTER JOIN 
    (
        SELECT
            *
        FROM core_rel.t_dispatch_group_2
        WHERE t_dispatch_group.lang_cd = 'EN'
    ) AS en 
    ON de.dispatch_grp_nr = en.dispatch_grp_nr
    AND de.int_org_sid = en.int_org_sid
UNION ALL
SELECT
    '@' AS dispatch_grp_nr,
    - NUMERIC '1' AS country_org_sid,
    'unbekannt' AS dispatch_grp_descr,
    'unknown' AS dispatch_grp_descr_en,
    'unbekannt' AS dispatch_grp_descr_de,
    - NUMERIC '1' AS dwh_load_id,
    'MANUAL' AS dwh_node_cd,
    NUMERIC '0' AS tf_error_fg,
    '' AS error_descr,
    NUMERIC '0' AS record_id,
    'core_rel' AS filename;