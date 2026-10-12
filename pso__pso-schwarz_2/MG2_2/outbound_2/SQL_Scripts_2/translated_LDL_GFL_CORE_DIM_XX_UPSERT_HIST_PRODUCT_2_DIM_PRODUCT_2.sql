INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (prod_sid, dwh_mapping_tmsp, dwh_valid_fg, prod_nr, prod_name, prod_descr, prod_creation_dt, prod_type_cd, prod_type_descr, item_type_cd, item_type_descr, prod_status_cd, prod_status_descr, prod_buying_status_cd, prod_buying_status_descr, prod_design_status_cd, prod_design_status_descr, packing_type_cd, packing_type_descr, goods_on_consingment_fg, excl_from_vat_calc_fg, country_specific_prod_fg, item_fam_sid, item_fam_nr, item_fam_name, sub_item_grp_sid, sub_item_grp_nr, sub_item_grp_name, food_fg, int_item_grp_sid, int_item_grp_nr, int_item_grp_name, pillar_sid, pillar_nr, pillar_name, main_pillar_sid, main_pillar_nr, main_pillar_name, specific_country_org_sid, specific_country_org_cd, dwh_load_id, dwh_node_cd, tf_error_fg, error_descr, record_id, filename, deleted_fg)
  SELECT DISTINCT
      p.prod_sid,
      p.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
      p.dwh_valid_fg,
      p.prod_nr,
      p.prod_name,
      COALESCE(p.prod_descr, '@') AS prod_descr,
      COALESCE(p.prod_creation_dt, CAST('1900-01-01 00:00:00' AS timestamp)),
      p.prod_type_cd,
      COALESCE(pt.prod_type_descr, '@'),
      COALESCE(p.item_type_cd, '@') AS item_type_cd,
      COALESCE(it.item_type_descr, '@') AS item_type_descr,
      '-1' AS prod_status_cd,
      '@' AS prod_status_descr,
      '-1' AS prod_buying_status_cd,
      '@' AS prod_buying_status_descr,
      '-1' AS prod_design_status_cd,
      '@' AS prod_design_status_descr,
      COALESCE(pack.packing_type_cd, '@') AS packing_type_cd,
      COALESCE(pack.packing_type_descr, '@') AS packing_type_descr,
      p.goods_on_consingment_fg,
      p.excl_from_vat_calc_fg,
      p.country_specific_prod_fg,
      COALESCE(pgh3.orig_prod_grp_sid, '-1') AS item_fam_sid,
      COALESCE(pgh3.orig_prod_grp_nr, '-1') AS item_fam_nr,
      COALESCE(pgh3.orig_prod_grp_name, '@') AS item_fam_name,
      COALESCE(pgh3.sub_item_grp_sid, '-1') AS sub_item_grp_sid,
      COALESCE(pgh3.sub_item_grp_nr, '-1') AS sub_item_grp_nr,
      COALESCE(pgh3.sub_item_grp_name, '@') AS sub_item_grp_name,
      CASE
        WHEN p.item_type_cd = 'FOOD' THEN TRUE
        ELSE FALSE
      END AS food_fg,
      COALESCE(pgh3.int_item_grp_sid, -NUMERIC '1') AS int_item_grp_sid,
      COALESCE(pgh3.int_item_grp_nr, -NUMERIC '1') AS int_item_grp_nr,
      COALESCE(pgh3.int_item_grp_name, '@') AS int_item_grp_name,
      '-1' AS pillar_sid,
      '-1' AS pillar_nr,
      '@' AS pillar_name,
      '-1' AS main_pillar_sid,
      '-1' AS main_pillar_nr,
      '@' AS main_pillar_name,
      IF(p.country_specific_prod_fg, COALESCE(lp.int_org_sid, -NUMERIC '1'), -NUMERIC '1') AS specific_country_org_sid,
      IF(p.country_specific_prod_fg, org.country_org_cd, NULL) AS specific_country_org_cd,
      ${load_id} AS dwh_load_id,
      p.dwh_node_cd AS dwh_node_cd,
      NUMERIC '0' AS tf_error_fg,
      '' AS error_descr,
      NUMERIC '0' AS record_id,
      't_product_2' AS filename,
      NUMERIC '0' AS deleted_fg
    FROM
      ldl_data_production.core_rel.t_product_2 AS p
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_type_2 AS pt ON p.prod_type_cd = pt.prod_type_cd
       AND pt.lang_cd = 'DE'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_item_type_2 AS it ON p.item_type_cd = it.item_type_cd
       AND it.lang_cd = 'DE'
      LEFT OUTER JOIN (
        SELECT
            prod_sid,
            MAX(pgh.prod_grp_sid) AS prod_grp_sid,
            pg1.dwh_valid_fg
          FROM
            ldl_data_production.core_rel.t_product_to_product_group_2 AS pgh
            INNER JOIN ldl_data_production.core_rel.t_product_group_2 AS pg1 ON pgh.prod_grp_sid = pg1.prod_grp_sid
             AND pg1.prod_grp_type_cd = 'IFG'
             AND pg1.dwh_valid_fg = TRUE
          WHERE pg1.dwh_valid_fg = TRUE
          GROUP BY 1, 3
      ) AS pgh ON pgh.prod_sid = p.prod_sid
      LEFT OUTER JOIN (
        SELECT
            pgh_level1.prod_grp_sid AS orig_prod_grp_sid,
            pg.prod_grp_nr AS orig_prod_grp_nr,
            pg.prod_grp_name AS orig_prod_grp_name,
            pgh_level3.prod_grp_sid AS int_item_grp_sid,
            pgh_level3.prod_grp_name AS int_item_grp_name,
            pgh_level3.prod_grp_nr AS int_item_grp_nr,
            pgh_level2.prod_grp_name AS sub_item_grp_name,
            pgh_level2.prod_grp_nr AS sub_item_grp_nr,
            pgh_level2.prod_grp_sid AS sub_item_grp_sid
          FROM
            ldl_data_production.core_rel.t_product_group_hierarchy_2 AS pgh_level1
            LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_2 AS pg ON pgh_level1.prod_grp_sid = pg.prod_grp_sid
             AND pg.prod_grp_type_cd = 'IFG'
             AND pg.dwh_valid_fg = NUMERIC '1'
            LEFT OUTER JOIN (
              SELECT
                  pgh_0.parent_prod_grp_sid,
                  pg1.prod_grp_sid,
                  pg1.prod_grp_name,
                  pg1.prod_grp_nr
                FROM
                  ldl_data_production.core_rel.t_product_group_2 AS pg1
                  LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_hierarchy_2 AS pgh_0 ON pgh_0.prod_grp_sid = pg1.prod_grp_sid
                   AND pgh_0.dwh_valid_fg = TRUE
                   AND pg1.dwh_valid_fg = TRUE
                   AND pg1.prod_grp_type_cd = 'SIG'
            ) AS pgh_level2 ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
            LEFT OUTER JOIN (
              SELECT
                  pg_0.prod_grp_sid,
                  pg_0.prod_grp_name,
                  pg_0.prod_grp_nr
                FROM
                  ldl_data_production.core_rel.t_product_group_2 AS pg_0
                WHERE pg_0.dwh_valid_fg = TRUE
                 AND pg_0.prod_grp_type_cd = 'IGI'
            ) AS pgh_level3 ON pgh_level2.parent_prod_grp_sid = pgh_level3.prod_grp_sid
      ) AS pgh3 ON pgh3.orig_prod_grp_sid = pgh.prod_grp_sid
      LEFT OUTER JOIN ldl_data_production.core_rel.t_local_product_2 AS lp ON p.prod_sid = lp.prod_sid
       AND lp.dwh_valid_fg = TRUE
      LEFT OUTER JOIN ldl_data_production.core_rel.t_internal_organization_2 AS org ON lp.int_org_sid = org.int_org_sid
       AND org.dwh_valid_fg = TRUE
      LEFT OUTER JOIN ldl_data_production.core_rel.t_packing_type_2 AS pack ON p.packing_type_cd = pack.packing_type_cd
    WHERE p.dwh_valid_fg = TRUE
  UNION DISTINCT
  SELECT
      -NUMERIC '1' AS prod_sid,
      '1900-01-01 00:00:00.000' AS dwh_mapping_tmsp,
      TRUE AS dwh_valid_fg,
      '@' AS prod_nr,
      '@' AS prod_name,
      '@' AS prod_descr,
      '1900-01-01 00:00:00.000' AS prod_creation_dt,
      '@' AS prod_type_cd,
      'unbekannt' AS prod_type_descr,
      '@' AS item_type_cd,
      'unbekannt' AS item_type_descr,
      '-1' AS prod_status_cd,
      'unbekannt' AS prod_status_descr,
      '-1' AS prod_buying_status_cd,
      '@' AS prod_buying_status_descr,
      '-1' AS prod_design_status_cd,
      'unbekannt' AS prod_design_status_descr,
      '@' AS packing_type_cd,
      'unbekannt' AS packing_type_descr,
      FALSE AS goods_on_consingment_fg,
      FALSE AS excl_from_vat_calc_fg,
      TRUE AS country_specific_prod_fg,
      '-1' AS item_fam_sid,
      '-1' AS item_fam_nr,
      '@' AS item_fam_name,
      '-1' AS sub_item_grp_sid,
      '-1' AS sub_item_grp_nr,
      '@' AS sub_item_grp_name,
      FALSE AS food_fg,
      -NUMERIC '1' AS int_item_grp_sid,
      -NUMERIC '1' AS int_item_grp_nr,
      '@' AS int_item_grp_name,
      '-1' AS pillar_sid,
      '-1' AS pillar_nr,
      '@' AS pillar_name,
      '-1' AS main_pillar_sid,
      '-1' AS main_pillar_nr,
      '@' AS main_pillar_name,
      -NUMERIC '1' AS specific_country_org_sid,
      NULL AS specific_country_org_cd,
      ${load_id} AS dwh_load_id,
      'DUMMY_2' AS dwh_node_cd,
      NUMERIC '0' AS tf_error_fg,
      '' AS error_descr,
      NUMERIC '0' AS record_id,
      'DUMMY_2' AS filename,
      NUMERIC '0' AS deleted_fg
;
