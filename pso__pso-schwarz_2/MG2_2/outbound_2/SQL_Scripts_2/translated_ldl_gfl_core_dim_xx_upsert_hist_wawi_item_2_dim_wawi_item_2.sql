INSERT INTO
    ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
        wawi_item_sid,
        country_org_sid,
        country_org_cd,
        wawi_item_nr,
        wawi_item_name,
        wawi_item_descr,
        wawi_item_creation_dt,
        wawi_item_status_cd,
        wawi_item_status_descr,
        item_fam_sid,
        item_fam_nr,
        item_fam_name,
        sub_item_grp_sid,
        sub_item_grp_nr,
        sub_item_grp_name,
        int_item_grp_sid,
        int_item_grp_nr,
        int_item_grp_name,
        food_fg,
        dwh_load_id,
        dwh_node_cd,
        dwh_mapping_tmsp,
        tf_error_fg,
        error_descr,
        record_id,
        filename,
        deleted_fg
    )
SELECT
    itm.wawi_item_sid,
    itm.country_org_sid,
    itm.country_org_cd,
    itm.wawi_item_nr,
    itm.wawi_item_name,
    itm.wawi_item_descr,
    itm.wawi_item_creation_dt,
    '@' AS wawi_item_status_cd,
    'Unbekannt' AS wawi_item_status_descr,
    COALESCE(pg1.prod_grp_sid, '-1') AS item_fam_sid,
    COALESCE(pg1.prod_grp_nr, '@') AS item_fam_nr,
    COALESCE(pg1.prod_grp_name, 'Unbekannt') AS item_fam_name,
    COALESCE(pg2.prod_grp_sid, '-1') AS sub_item_grp_sid,
    COALESCE(pg2.prod_grp_nr, '@') AS sub_item_grp_nr,
    COALESCE(pg2.prod_grp_name, 'Unbekannt') AS sub_item_grp_name,
    COALESCE(pg3.prod_grp_sid, - NUMERIC '1') AS int_item_grp_sid,
    COALESCE(pg3.prod_grp_nr, '@') AS int_item_grp_nr,
    COALESCE(pg3.prod_grp_name, 'Unbekannt') AS int_item_grp_name,
    NUMERIC '0' AS food_fg,
    ${load_id} AS dwh_load_id,
    itm.dwh_node_cd,
    itm.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
    NUMERIC '0' AS tf_error_fg,
    '' AS error_descr,
    NUMERIC '0' AS record_id,
    '${SRC_INPUT_TABLE}' AS filename,
    NUMERIC '0' AS deleted_fg
FROM
    core_rel.t_wawi_item_2 AS itm
    LEFT OUTER JOIN core_rel.t_wawi_item_to_product_group_2 AS itmpg  /* Item_2 to the Item_2-Family-Group*/
    ON itm.wawi_item_sid = itmpg.wawi_item_sid
    AND itmpg.prod_grp_type_cd = 'IFG'   /* Item_2-Family-Group*/
    AND itmpg.dwh_valid_fg
    LEFT OUTER JOIN core_rel.t_product_group_2 AS pg1   /* Item_2-Family-Group*/
    ON itmpg.prod_grp_sid = pg1.prod_grp_sid
    AND pg1.dwh_valid_fg
    LEFT OUTER JOIN core_rel.t_product_group_hierarchy_2 AS pgh1   /* Item_2-Family-Group to the Sub-Item_2-Group*/
    ON pg1.prod_grp_sid = pgh1.prod_grp_sid
    AND pgh1.prod_grp_hierarchy_type_cd = 'IGH'    /* Item_2-Group-Hierarchy_2*/
    AND pgh1.dwh_valid_fg
    LEFT OUTER JOIN core_rel.t_product_group_2 AS pg2    /* Sub-Item_2-Group*/
    ON pgh1.parent_prod_grp_sid = pg2.prod_grp_sid
    AND pg2.dwh_valid_fg
    LEFT OUTER JOIN core_rel.t_product_group_hierarchy_2 AS pgh2    /* Sub-Item_2-Group to the Item_2-Group-International*/
    ON pg2.prod_grp_sid = pgh2.prod_grp_sid
    AND pgh2.prod_grp_hierarchy_type_cd = 'IGH'    /* Item_2-Group-Hierarchy_2*/
    AND pgh2.dwh_valid_fg
    LEFT OUTER JOIN core_rel.t_product_group_2 AS pg3    /* Item_2-Group-International*/
    ON pgh2.parent_prod_grp_sid = pg3.prod_grp_sid
    AND pg3.dwh_valid_fg
WHERE
    itm.dwh_valid_fg;