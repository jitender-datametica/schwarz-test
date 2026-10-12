
-- hs_list_txt,
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_src_file_name, tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename,
 product_status_cd, incoterm_name, product_division_type_cd, product_name_txt, product_name, ian_nr, product_sid)
(SELECT p.dwh_src_file_name,
  0 AS tf_error_fg,
  p.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  p.dwh_valid_fg,
  CAST(0 AS STRING) AS record_id,
  p.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  p.dwh_src_file_name AS filename,
  -- p.hs_list_txt,
 p.product_status_cd,
  p.incoterm_name,
  p.product_division_type_cd,
  p.product_name AS product_name_txt,
  p.product_name,
  CAST(p.ian_nr AS STRING) AS ian_nr,
  p.product_sid
 FROM szd_production_core_rel.t_product AS p
  LEFT JOIN szd_production_core.t_dim_product AS dp ON p.product_sid = dp.product_sid
 WHERE dp.product_sid IS NULL
  AND p.dwh_valid_fg);