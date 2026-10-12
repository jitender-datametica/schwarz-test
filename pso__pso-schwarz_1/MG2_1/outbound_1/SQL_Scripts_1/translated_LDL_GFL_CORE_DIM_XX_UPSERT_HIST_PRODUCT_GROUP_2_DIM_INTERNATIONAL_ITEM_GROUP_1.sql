INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (int_item_grp_sid, int_item_grp_nr, int_item_grp_name, int_item_grp_name_de, int_item_grp_name_en, prod_grp_status_cd, prod_grp_status_descr, dwh_mapping_tmsp, dwh_valid_fg, dwh_load_id, dwh_node_cd, tf_error_fg, error_descr, record_id, filename, deleted_fg)
  SELECT
      pg1.prod_grp_sid,
      pg1.prod_grp_nr,
      pg1.prod_grp_name,
      COALESCE(pgn.prod_grp_name, '@'),
      COALESCE(pge.prod_grp_name, '@'),
      COALESCE(pgs.prod_grp_status_type_cd, '@'),
      COALESCE(pgst.prod_grp_status_type_descr, '@'),
      pg1.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
      pg1.dwh_valid_fg,
      ${load_id} AS dwh_load_id,
      pg1.dwh_node_cd,
      NUMERIC '0' AS tf_error_fg,
      '' AS error_descr,
      NUMERIC '0' AS record_id,
      'core_rel' AS filename,
      NUMERIC '0' AS deleted_fg
    FROM
      ldl_data_production.core_rel.t_product_group_1 AS pg1
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_name_1 AS pgn ON pg1.prod_grp_sid = pgn.prod_grp_sid
       AND pgn.dwh_valid_fg
       AND pgn.lang_cd = 'DE'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_name_1 AS pge ON pg1.prod_grp_sid = pge.prod_grp_sid
       AND pge.dwh_valid_fg
       AND pge.lang_cd = 'EN'
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_status_1 AS pgs ON pg1.prod_grp_sid = pgs.prod_grp_sid
       AND pgs.dwh_valid_fg
      LEFT OUTER JOIN ldl_data_production.core_rel.t_product_group_status_type_1 AS pgst ON pgs.prod_grp_status_type_cd = pgst.prod_grp_status_type_cd
       AND pgst.lang_cd = 'DE'
    WHERE pg1.prod_grp_type_cd = 'IGI'
  UNION DISTINCT
  SELECT
      -NUMERIC '1' AS int_item_grp_sid,
      '@' AS int_item_grp_nr,
      '@' AS int_item_grp_name,
      '@' AS int_item_grp_name_de,
      '@' AS int_item_grp_name_en,
      '@' AS prod_grp_status_cd,
      '@' AS prod_grp_status_descr,
      '1900-01-01 00:00:00.000' AS dwh_mapping_tmsp,
      TRUE AS dwh_valid_fg,
      ${load_id} AS dwh_load_id,
      'DUMMY_1' AS dwh_node_cd,
      NUMERIC '0' AS tf_error_fg,
      '' AS error_descr,
      NUMERIC '0' AS record_id,
      'DUMMY_1' AS filename,
      NUMERIC '0' AS deleted_fg
;
