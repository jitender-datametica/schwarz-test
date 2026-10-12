INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
    logistic_variant_sid,
    country_org_sid,
    country_org_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    local_logistic_variant_nr,
    local_logistic_variant_name,
    prod_variant_status_cd,
    prod_variant_status_descr,
    prod_sid,
    prod_nr,
    prod_name,
    item_fam_sid,
    item_fam_nr,
    item_fam_name,
    sub_item_grp_sid,
    sub_item_grp_nr,
    sub_item_grp_name,
    int_item_grp_sid,
    int_item_grp_nr,
    int_item_grp_name,
    pillar_sid,
    pillar_nr,
    pillar_name,
    main_pillar_sid,
    main_pillar_nr,
    main_pillar_name,
    dwh_mapping_tmsp,
    dwh_load_id,
    dwh_node_cd,
    tf_error_fg,
    error_descr,
    record_id,
    filename
)
SELECT
    lpv.prod_variant_sid AS logistic_variant_sid,
    lpv.int_org_sid AS country_org_sid,
    int_org.country_org_cd AS country_org_cd,
    lpv.dwh_valid_from_tmsp AS dwh_valid_from_tmsp,
    lpv.dwh_valid_to_tmsp AS dwh_valid_to_tmsp,
    lpv.dwh_valid_fg AS dwh_valid_fg,
    lpv.local_prod_variant_nr AS local_logistic_variant_nr,
    lpv.local_prod_variant_name AS local_logistic_variant_name,
    '@' AS prod_variant_status_cd,
    'Unbekannt' AS prod_variant_status_descr,
    COALESCE(pv.prod_sid, - NUMERIC '1') AS prod_sid,
    COALESCE(p.prod_nr, '@') AS prod_nr,
    COALESCE(p.prod_name, 'Unbekannt') AS prod_name,
    COALESCE(ifg.prod_grp_sid, - NUMERIC '1') AS item_fam_sid,
    COALESCE(ifg.prod_grp_nr, '@') AS item_fam_nr,
    COALESCE(ifg.prod_grp_name, 'Unbekannt') AS item_fam_name,
    COALESCE(sig.prod_grp_sid, - NUMERIC '1') AS sub_item_grp_sid,
    COALESCE(sig.prod_grp_nr, '@') AS sub_item_grp_nr,
    COALESCE(sig.prod_grp_name, 'Unbekannt') AS sub_item_grp_name,
    COALESCE(igi.prod_grp_sid, - NUMERIC '1') AS int_item_grp_sid,
    COALESCE(igi.prod_grp_nr, '@') AS int_item_grp_nr,
    COALESCE(igi.prod_grp_name, 'Unbekannt') AS int_item_grp_name,
    COALESCE(pil.prod_grp_sid, - NUMERIC '1') AS pillar_sid,
    COALESCE(pil.prod_grp_nr, '@') AS pillar_nr,
    COALESCE(pil.prod_grp_name, 'Unbekannt') AS pillar_name,
    COALESCE(mpil.prod_grp_sid, - NUMERIC '1') AS main_pillar_sid,
    COALESCE(mpil.prod_grp_nr, '@') AS main_pillar_nr,
    COALESCE(mpil.prod_grp_name, 'Unbekannt') AS main_pillar_name,
    pv.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
    ${load_id} AS dwh_load_id,
    'CORE_REL' AS dwh_node_cd,
    NUMERIC '0' AS tf_error_fg,
    '' AS error_descr,
    NUMERIC '0' AS record_id,
    'core_rel' AS filename
FROM core_rel.t_local_product_variant_2 AS lpv
INNER JOIN core_rel.t_product_variant_2 AS pv
    ON lpv.prod_variant_sid = pv.prod_variant_sid
    AND pv.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_2 AS p
    ON pv.prod_sid = p.prod_sid
    AND p.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_to_product_group_2 AS pifg
    ON p.prod_sid = pifg.prod_sid
    AND pifg.prod_grp_type_cd = 'IFG'
    AND pifg.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_group_2 AS ifg
    ON pifg.prod_grp_sid = ifg.prod_grp_sid
    AND ifg.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_group_hierarchy_2 AS ifgh
    ON ifg.prod_grp_sid = ifgh.prod_grp_sid
    AND ifgh.prod_grp_hierarchy_type_cd = 'IGH'
    AND ifgh.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_group_2 AS sig
    ON ifgh.parent_prod_grp_sid = sig.prod_grp_sid
    AND sig.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_group_hierarchy_2 AS sigh
    ON ifgh.parent_prod_grp_sid = sigh.prod_grp_sid
    AND sigh.prod_grp_hierarchy_type_cd = 'IGH'
    AND sigh.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_group_2 AS igi
    ON sigh.parent_prod_grp_sid = igi.prod_grp_sid
    AND igi.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_to_product_group_2 AS ppil
    ON p.prod_sid = ppil.prod_sid
    AND ppil.prod_grp_type_cd = 'P'
    AND ppil.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_group_2 AS pil
    ON ppil.prod_grp_sid = pil.prod_grp_sid
    AND pil.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_group_hierarchy_2 AS pilh
    ON pil.prod_grp_sid = pilh.prod_grp_sid
    AND pilh.prod_grp_hierarchy_type_cd = 'PH'
    AND pilh.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_product_group_2 AS mpil
    ON pilh.parent_prod_grp_sid = mpil.prod_grp_sid
    AND mpil.dwh_valid_fg = TRUE
LEFT OUTER JOIN core_rel.t_internal_organization_2 AS int_org
    ON lpv.int_org_sid = int_org.int_org_sid
    AND int_org.dwh_valid_fg = TRUE
WHERE pv.prod_variant_type_cd = 'LOGISTIC'
  AND lpv.dwh_valid_fg = TRUE;
