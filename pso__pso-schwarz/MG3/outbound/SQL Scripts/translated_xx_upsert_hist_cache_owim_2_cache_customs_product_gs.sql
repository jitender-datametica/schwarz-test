
-- products from gs upload for lidl stiftung
 -- products from gs upload for owim
 INSERT INTO
${temp_db}.${src2tgt_temp_table1}_${src_context_area} (article_number,
 allocation, dwh_src_file_name, tf_error_fg, country_of_origin, customs_tariff_number, article, preferential_origin,
 tax_code, quantity_in_uom, dwh_src_1_tmsp, deleted_fg, unit_of_measure, dwh_valid_fg, record_id, dwh_mapping_tmsp,
 filename)
(SELECT article_number,
  allocation,
  dwh_src_file_name,
  tf_error_fg,
  country_of_origin,
  customs_tariff_number,
  article,
  preferential_origin,
  tax_code,
  quantity_in_uom,
  dwh_src_1_tmsp,
   deleted_fg <> 0 AS deleted_fg,
  unit_of_measure,
   dwh_valid_fg <> 0 AS dwh_valid_fg,
  CAST(record_id AS STRING) AS record_id,
  dwh_mapping_tmsp,
  filename
 FROM (SELECT DISTINCT article_number,
     article,
     customs_tariff_number,
     country_of_origin,
     preferential_origin,
     allocation,
     tax_code,
     quantity_in_uom,
     unit_of_measure,
     dwh_src_1_tmsp,
     dwh_src_file_name,
     dwh_src_1_tmsp AS dwh_mapping_tmsp,
     1 AS dwh_valid_fg,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     dwh_src_file_name AS filename
    FROM szd_production_etl.t_cache_list
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY article_number, customs_tariff_number, country_of_origin, allocation
        ORDER BY 1 IS NULL, 1)) = 1
    UNION ALL
    SELECT DISTINCT article_number,
     article,
     customs_tariff_number,
     country_of_origin,
     preferential_origin,
     allocation,
     tax_code,
     quantity_in_uom,
     unit_of_measure,
     dwh_src_1_tmsp,
     dwh_src_file_name,
     dwh_src_1_tmsp AS dwh_mapping_tmsp,
     1 AS dwh_valid_fg,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     dwh_src_file_name AS filename
    FROM szd_production_etl.t_cache_owim
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY article_number, customs_tariff_number, country_of_origin, allocation
        ORDER BY 1 IS NULL, 1)) = 1) AS t5);