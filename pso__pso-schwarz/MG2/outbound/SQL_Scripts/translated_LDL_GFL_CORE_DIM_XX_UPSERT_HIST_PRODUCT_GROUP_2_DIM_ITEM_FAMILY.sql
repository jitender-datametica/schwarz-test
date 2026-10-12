INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (item_fam_sid, item_fam_nr, item_fam_name, item_fam_name_de, item_fam_name_en, prod_grp_status_cd, prod_grp_status_descr, sub_item_grp_sid, sub_item_grp_nr, sub_item_grp_name, food_fg, int_item_grp_sid, int_item_grp_nr, int_item_grp_name, dwh_mapping_tmsp, dwh_valid_fg, dwh_load_id, dwh_node_cd, tf_error_fg, error_descr, record_id, filename, deleted_fg)
  SELECT
      pg1.prod_grp_sid,
      pg1.prod_grp_nr,
      pg1.prod_grp_name,
      COALESCE(pgn.prod_grp_name, '@'),
      COALESCE(pge.prod_grp_name, '@'),
      COALESCE(pgs.prod_grp_status_type_cd, '@'),
      COALESCE(pgst.prod_grp_status_type_descr, '@'),
      COALESCE(pgh1.parent_prod_grp_sid, -NUMERIC '1'),
      COALESCE(pg2.prod_grp_nr, '@'),
      COALESCE(pg2.prod_grp_name, '@'),
      CASE
        WHEN pg2.prod_grp_nr BETWEEN NUMERIC '20' AND NUMERIC '99' THEN TRUE
        ELSE FALSE
      END,
      COALESCE(pgh2.parent_prod_grp_sid, -NUMERIC '1'),
      COALESCE(pg3.prod_grp_nr, '@'),
      COALESCE(pg3.prod_grp_name, '@'),
      pg1.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
      pg1.dwh_valid_fg,
      ${load_id},
      pg1.dwh_node_cd,
      NUMERIC '0' AS tf_error_fg,
      '' AS error_descr,
      NUMERIC '0' AS record_id,
      'core_rel' AS filename,
      NUMERIC '0' AS deleted_fg
    FROM
      ldl_data_production.core_rel.t_product_group AS pg1
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_name AS pgn ON pg1.prod_grp_sid = pgn.prod_grp_sid
       AND pgn.dwh_valid_fg
       AND pgn.lang_cd = 'DE'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_name AS pge ON pg1.prod_grp_sid = pge.prod_grp_sid
       AND pge.dwh_valid_fg
       AND pge.lang_cd = 'EN'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_status AS pgs ON pg1.prod_grp_sid = pgs.prod_grp_sid
       AND pgs.dwh_valid_fg
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_status_type AS pgst ON pgs.prod_grp_status_type_cd = pgst.prod_grp_status_type_cd
       AND pgst.lang_cd = 'DE'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_hierarchy AS pgh1 ON pg1.prod_grp_sid = pgh1.prod_grp_sid
       AND pgh1.dwh_valid_fg
       AND pgh1.prod_grp_hierarchy_type_cd = 'IGH'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group AS pg2 ON pgh1.parent_prod_grp_sid = pg2.prod_grp_sid
       AND pg2.dwh_valid_fg
       AND pg2.prod_grp_type_cd = 'SIG'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_hierarchy AS pgh2 ON pg2.prod_grp_sid = pgh2.prod_grp_sid
       AND pgh2.dwh_valid_fg
       AND pgh2.prod_grp_hierarchy_type_cd = 'IGH'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group AS pg3 ON pgh2.parent_prod_grp_sid = pg3.prod_grp_sid
       AND pg3.dwh_valid_fg
       AND pg3.prod_grp_type_cd = 'IGI'
    WHERE pg1.prod_grp_type_cd = 'IFG'
  UNION DISTINCT
  SELECT
      -NUMERIC '1' AS prod_grp_sid,
      '@' AS prod_grp_nr,
      '@' AS prod_grp_name,
      '@' AS prod_grp_name,
      '@' AS prod_grp_name,
      '@' AS prod_grp_status_type_cd,
      '@' AS prod_grp_status_type_descr,
      -NUMERIC '1' AS parent_prod_grp_sid,
      '@' AS prod_grp_nr,
      '@' AS prod_grp_name,
      FALSE AS food_fg,
      -NUMERIC '1' AS parent_prod_grp_sid,
      '@' AS prod_grp_nr,
      '@' AS prod_grp_name,
      '1900-01-01 00:00:00.000' AS dwh_mapping_tmsp,
      TRUE AS dwh_valid_fg,
      ${load_id} AS dwh_load_id,
      'DUMMY' AS dwh_node_cd,
      NUMERIC '0' AS tf_error_fg,
      '' AS error_descr,
      NUMERIC '0' AS record_id,
      'DUMMY' AS filename,
      NUMERIC '0' AS deleted_fg
;
