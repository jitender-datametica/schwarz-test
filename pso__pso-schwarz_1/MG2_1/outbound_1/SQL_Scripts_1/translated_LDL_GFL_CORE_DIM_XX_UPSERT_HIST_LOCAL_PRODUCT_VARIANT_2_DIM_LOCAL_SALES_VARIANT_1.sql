INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (sales_variant_sid, country_org_sid, country_org_cd, local_sales_variant_nr, local_sales_variant_name, prod_variant_status_cd, prod_variant_status_descr, prod_sid, prod_nr, prod_name, item_fam_sid, item_fam_nr, item_fam_name, sub_item_grp_sid, sub_item_grp_nr, sub_item_grp_name, int_item_grp_sid, int_item_grp_nr, int_item_grp_name, pillar_sid, pillar_nr, pillar_name, main_pillar_sid, main_pillar_nr, main_pillar_name, dwh_load_id, dwh_node_cd, dwh_mapping_tmsp, dwh_valid_fg, tf_error_fg, record_id, filename)
  SELECT
      -- extraction_tmsp,
      lpv.prod_variant_sid,
      lpv.int_org_sid,
      int_org.country_org_cd,
      lpv.local_prod_variant_nr,
      lpv.local_prod_variant_name,
      '@' AS prod_variant_status_cd,
      'Unbekannt' AS prod_variant_status_descr,
      lpv.prod_sid,
      coalesce(prod.local_prod_nr, '@'),
      coalesce(prod.local_prod_name, 'Unbekannt'),
      coalesce(p_2_pg.prod_grp_sid, -NUMERIC '1'),
      coalesce(pg.prod_grp_nr, '@'),
      coalesce(pg.prod_grp_name, 'Unbekannt'),
      coalesce(tgh.sub_item_grp_sid, -NUMERIC '1'),
      coalesce(tgh.sub_item_grp_nr, '@'),
      coalesce(tgh.sub_item_grp_name, 'Unbekannt'),
      coalesce(pgh_level3.prod_grp_sid, -NUMERIC '1'),
      coalesce(pgh_level3.prod_grp_nr, '@'),
      coalesce(pgh_level3.prod_grp_name, 'Unbekannt'),
      '-1' AS pilar_sid,
      '@' AS pilar_nr,
      'unbekannt' AS pilar_name,
      '-1' AS main_pilar_sid,
      '@' AS main_pilar_nr,
      'unbekannt' AS main_pilar_name,
      ${load_id} AS dwh_load_id,
      lpv.dwh_node_cd,
      lpv.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
      lpv.dwh_valid_fg,
      -- current_timestamp extraction_tmsp,
      NUMERIC '0' AS tf_error_fg,
      NUMERIC '0' AS record_id,
      'core_rel' AS filename
    FROM
      ldl_data_production.core_rel.t_local_product_variant_1 AS lpv
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_variant_1 AS pv ON lpv.prod_variant_sid = pv.prod_variant_sid
       AND pv.dwh_valid_fg = true
      LEFT OUTER JOIN ldl_data_production.core_rel.t_internal_organization_1 AS int_org ON lpv.int_org_sid = int_org.int_org_sid
       AND int_org.dwh_valid_fg = true
      INNER JOIN ldl_data_production.core_rel.t_local_product_1 AS prod ON prod.dwh_valid_fg = true
       AND prod.prod_sid = lpv.prod_sid
       AND prod.int_org_sid = lpv.int_org_sid
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_to_product_group_1 AS p_2_pg ON p_2_pg.prod_sid = prod.prod_sid
       AND p_2_pg.dwh_valid_fg = true
       AND p_2_pg.prod_grp_type_cd = 'IFG'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_1 AS pg ON p_2_pg.prod_grp_sid = pg.prod_grp_sid
       AND pg.prod_grp_type_cd = 'IFG'
       AND pg.dwh_valid_fg = true
      LEFT OUTER JOIN (
        SELECT DISTINCT
            pgh_level1.parent_prod_grp_sid,
            pgh_level2.prod_grp_sid AS sub_item_grp_sid,
            pgh_level2.prod_grp_name AS sub_item_grp_name,
            pgh_level2.prod_grp_nr AS sub_item_grp_nr
          FROM
            ldl_data_production.core_rel.t_product_group_hierarchy_1 AS pgh_level1
            LEFT OUTER JOIN (
              SELECT
                  pgh.parent_prod_grp_sid,
                  pg1.prod_grp_sid,
                  pg1.prod_grp_name,
                  pg1.prod_grp_nr
                FROM
                  ldl_data_production.core_rel.t_product_group_1 AS pg1
                  LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_hierarchy_1 AS pgh ON pgh.prod_grp_sid = pg1.prod_grp_sid
                   AND pgh.dwh_valid_fg = true
                   AND pg1.dwh_valid_fg = true
                   AND pg1.prod_grp_type_cd = 'SIG'
            ) AS pgh_level2 ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
      ) AS tgh ON tgh.parent_prod_grp_sid = p_2_pg.prod_grp_sid
      LEFT OUTER JOIN (
        SELECT DISTINCT
            pgh_level2.parent_prod_grp_sid,
            pgh_level3_0.prod_grp_sid,
            pgh_level3_0.prod_grp_nr,
            pgh_level3_0.prod_grp_name
          FROM
            ldl_data_production.core_rel.t_product_group_hierarchy_1 AS pgh_level1
            LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_1 AS pg_0 ON pgh_level1.prod_grp_sid = pg_0.prod_grp_sid
             AND pg_0.prod_grp_type_cd = 'IFG'
            LEFT OUTER JOIN (
              SELECT
                  pgh.parent_prod_grp_sid,
                  pg1.prod_grp_sid,
                  pg1.prod_grp_name,
                  pg1.prod_grp_nr
                FROM
                  ldl_data_production.core_rel.t_product_group_1 AS pg1
                  LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_hierarchy_1 AS pgh ON pgh.prod_grp_sid = pg1.prod_grp_sid
                   AND pgh.dwh_valid_fg = true
                   AND pg1.dwh_valid_fg = true
                   AND pg1.prod_grp_type_cd = 'SIG'
            ) AS pgh_level2 ON pgh_level1.parent_prod_grp_sid = pgh_level2.prod_grp_sid
            LEFT OUTER JOIN (
              SELECT
                  pg_1.prod_grp_sid,
                  pg_1.prod_grp_name,
                  pg_1.prod_grp_nr
                FROM
                  ldl_data_production.core_rel.t_product_group_1 AS pg_1
                WHERE pg_1.dwh_valid_fg = true
                 AND pg_1.prod_grp_type_cd = 'IGI'
            ) AS pgh_level3_0 ON pgh_level2.parent_prod_grp_sid = pgh_level3_0.prod_grp_sid
      ) AS pgh_level3 ON tgh.sub_item_grp_sid = pgh_level3.parent_prod_grp_sid
    WHERE lpv.dwh_valid_fg = true
     AND pv.prod_variant_type_cd = 'SALES_1'
;
