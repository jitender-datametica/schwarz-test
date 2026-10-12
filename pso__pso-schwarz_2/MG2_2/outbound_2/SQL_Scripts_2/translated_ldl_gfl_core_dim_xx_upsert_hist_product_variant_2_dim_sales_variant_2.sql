INSERT INTO
    ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
        sales_variant_sid,
        dwh_valid_from_tmsp,
        dwh_valid_to_tmsp,
        dwh_valid_fg,
        sales_variant_nr,
        gtin,
        sales_variant_name,
        prod_variant_status_cd,
        prod_variant_status_descr,
        sales_variant_type_cd,
        sales_variant_type_descr,
        weight_based_fg,
        sales_variant_content_meas,
        unit_cnt,
        unit_content_meas,
        content_uom_cd,
        non_food_variant_type_cd,
        non_food_variant_type_descr,
        size_name,
        style_name,
        kind_name,
        fruits_and_vegetables_class_cd,
        fruits_and_vegetables_class_descr,
        min_caliber_meas,
        max_caliber_meas,
        caliber_uom_cd,
        country_of_origin_cd,
        country_of_origin_name,
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
        dwh_node_cd,
        extraction_tmsp,
        dwh_mapping_tmsp,
        tf_error_fg,
        record_id,
        dwh_load_id,
        filename
    )
SELECT
    pv.prod_variant_sid AS sales_variant_sid,
    pv.dwh_valid_from_tmsp AS dwh_valid_from_tmsp,
    pv.dwh_valid_to_tmsp AS dwh_valid_to_tmsp,
    pv.dwh_valid_fg AS dwh_valid_fg,
    SUBSTR(prod_variant_nr, 1, 20) AS sales_variant_nr,
    pv.gtin AS gtin,
    COALESCE(prod_variant_name, 'Unbekannt') AS sales_variant_name,
    'na' AS prod_variant_status_cd,
    'na' AS prod_variant_status_descr,
    COALESCE(pv.sales_variant_type_cd, '@') AS sales_variant_type_cd,
    COALESCE(sales_variant_type_descr, '@') AS sales_variant_type_descr,
    COALESCE(weight_based_fg, FALSE) AS weight_based_fg,
    pv.sales_variant_content_meas AS sales_variant_content_meas,
    COALESCE(unit_cnt, NUMERIC '0') AS unit_cnt,
    pv.unit_content_meas AS unit_content_meas,
    COALESCE(um.uom_cd, '@') AS content_uom_cd,
    COALESCE(pv.non_food_variant_type_cd, '@') AS non_food_variant_type_cd,
    COALESCE(non_food_variant_type_descr, '@') AS non_food_variant_type_descr,
    pv.size_name AS size_name,
    pv.style_name AS style_name,
    pv.kind_name AS kind_name,
    COALESCE(pv.fruits_and_vegetables_class_cd, '@') AS fruits_and_vegetables_class_cd,
    COALESCE(fruits_and_vegetables_class_descr, '@') AS fruits_and_vegetables_class_descr,
    pv.min_caliber_meas AS min_caliber_meas,
    pv.max_caliber_meas AS max_caliber_meas,
    COALESCE(pv.caliber_uom_cd, '@') AS caliber_uom_cd,
    COALESCE(iso_country_cd, '@') AS country_of_origin_cd,
    COALESCE(country_name, '@') AS country_of_origin_name,
    COALESCE(pv.prod_sid, - NUMERIC '1') AS prod_sid,
    COALESCE(prod.prod_nr, '@') AS prod_nr,
    COALESCE(prod.prod_name, 'Unbekannt') AS prod_name,
    COALESCE(fam.fam_grp_sid, - NUMERIC '1') AS item_fam_sid,
    COALESCE(fam.fam_group_nr, '@') AS item_fam_nr,
    COALESCE(fam.fam_group_name, '@') AS item_fam_name,
    COALESCE(sub.sub_item_grp_sid, - NUMERIC '1') AS sub_item_grp_sid,
    COALESCE(sub.sub_item_grp_nr, '@') AS sub_item_grp_nr,
    COALESCE(sub.sub_item_grp_name, '@') AS sub_item_grp_name,
    COALESCE(int.int_item_grp_sid, - NUMERIC '1') AS int_item_grp_sid,
    COALESCE(int.int_item_grp_nr, '@') AS int_item_grp_nr,
    COALESCE(int.int_item_grp_name, '@') AS int_item_grp_name,
    - NUMERIC '1' AS pillar_sid,
    '@' AS pillar_nr,
    '@' AS pillar_name,
    - NUMERIC '1' AS main_pillar_sid,
    '@' AS main_pillar_nr,
    '@' AS main_pillar_name,
    pv.dwh_node_cd,
    CURRENT_TIMESTAMP() AS extraction_tmsp,
    pv.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS record_id,
    ${load_id} AS dwh_load_id,
    'core_rel' AS filename
FROM
    core_rel.t_product_variant_2 AS pv
    LEFT OUTER JOIN core_rel.t_sales_variant_type_2 AS svt ON svt.sales_variant_type_cd = pv.sales_variant_type_cd
    AND svt.lang_cd = 'DE'
    LEFT OUTER JOIN core_rel.t_non_food_variant_type_2 AS nfvt ON nfvt.non_food_variant_type_cd = pv.non_food_variant_type_cd
    AND nfvt.lang_cd = 'DE'
    LEFT OUTER JOIN core_rel.t_fruits_and_vegetables_class_2 AS fvc ON fvc.fruits_and_vegetables_class_cd = pv.fruits_and_vegetables_class_cd
    AND fvc.lang_cd = 'DE'
    LEFT OUTER JOIN core_rel.t_country_2 AS cntr ON cntr.country_sid = pv.country_of_origin_sid
    AND cntr.dwh_valid_fg
    LEFT OUTER JOIN core_rel.t_product_2 AS prod ON prod.dwh_valid_fg = TRUE
    AND prod.prod_sid = pv.prod_sid
    LEFT OUTER JOIN (
        SELECT
            prod_sid,
            pgh.prod_grp_sid AS fam_grp_sid,
            pg.dwh_valid_fg,
            prod_grp_nr AS fam_group_nr,
            prod_grp_name AS fam_group_name
        FROM
            core_rel.t_product_to_product_group_2 AS pgh
            INNER JOIN core_rel.t_product_group_2 AS pg ON pgh.prod_grp_sid = pg.prod_grp_sid
            AND pg.prod_grp_type_cd = 'IFG'
            AND pg.dwh_valid_fg = TRUE
        WHERE
            pgh.dwh_valid_fg = TRUE
    ) AS fam ON fam.prod_sid = prod.prod_sid
    LEFT OUTER JOIN (
        SELECT
            pgh_level1.prod_grp_sid AS fam_grp_sid,
            pgh_level2.prod_grp_sid AS sub_item_grp_sid,
            pgh_level2.prod_grp_name AS sub_item_grp_name,
            pgh_level2.prod_grp_nr AS sub_item_grp_nr
        FROM
            core_rel.t_product_group_hierarchy_2 AS pgh_level1
            LEFT JOIN (
                SELECT
                    pgh.parent_prod_grp_sid,
                    pg1.prod_grp_sid,
                    pg1.prod_grp_name,
                    pg1.prod_grp_nr
                FROM
                    core_rel.t_product_group_2 AS pg1
                    LEFT JOIN core_rel.t_product_group_hierarchy_2 AS pgh ON pgh.prod_grp_sid = pg1.prod_grp_sid
                    AND pgh.dwh_valid_fg = TRUE
                    AND pg1.dwh_valid_fg = TRUE
                    AND pg1.prod_grp_type_cd = 'SIG'
            ) AS pgh_level2 ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
        WHERE
            pgh_level1.dwh_valid_fg
    ) AS sub ON sub.fam_grp_sid = fam.fam_grp_sid
    LEFT OUTER JOIN (
        SELECT
            pgh_level1.prod_grp_sid AS fam_item_grp_sid,
            pgh_level3.prod_grp_sid AS int_item_grp_sid,
            pgh_level3.prod_grp_name AS int_item_grp_name,
            pgh_level3.prod_grp_nr AS int_item_grp_nr
        FROM
            core_rel.t_product_group_hierarchy_2 AS pgh_level1
            LEFT JOIN core_rel.t_product_group_2 AS pg ON pgh_level1.prod_grp_sid = pg.prod_grp_sid
            AND pg.dwh_valid_fg = TRUE
            AND pg.prod_grp_type_cd = 'IFG'
            LEFT JOIN (
                SELECT
                    pgh.parent_prod_grp_sid,
                    pg1.prod_grp_sid,
                    pg1.prod_grp_name,
                    pg1.prod_grp_nr
                FROM
                    core_rel.t_product_group_2 AS pg1
                    LEFT JOIN core_rel.t_product_group_hierarchy_2 AS pgh ON pgh.prod_grp_sid = pg1.prod_grp_sid
                    AND pgh.dwh_valid_fg = TRUE
                    AND pg1.dwh_valid_fg = TRUE
                    AND pg1.prod_grp_type_cd = 'SIG'
            ) AS pgh_level2 ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
            LEFT JOIN (
                SELECT
                    pg_0.prod_grp_sid,
                    pg_0.prod_grp_name,
                    pg_0.prod_grp_nr
                FROM
                    core_rel.t_product_group_2 AS pg_0
                WHERE
                    pg_0.dwh_valid_fg = TRUE
                    AND pg_0.prod_grp_type_cd = 'IGI'
            ) AS pgh_level3 ON pgh_level2.parent_prod_grp_sid = pgh_level3.prod_grp_sid
        WHERE
            pgh_level1.dwh_valid_fg = TRUE
    ) AS int ON int.fam_item_grp_sid = fam.fam_grp_sid
    LEFT OUTER JOIN core_dim.t_dim_unit_of_measure_2 AS um ON UPPER(pv.caliber_uom_cd) = UPPER(um.uom_cd)
WHERE
    pv.dwh_valid_fg = TRUE
    AND prod_variant_type_cd = 'SALES_2';