INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, item_non_preferential_country_code,
 item_commodity_code, item_national_additional_code, item_product, item_description, item_preferential_country_code,
 importer_eori)
(SELECT dwh_src_file_name,
  tf_error_fg,
  dwh_src_1_tmsp,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  dwh_mapping_tmsp,
  filename,
  item_non_preferential_country_code,
  item_commodity_code,
  item_national_additional_code,
  item_product,
  item_description,
  item_preferential_country_code,
  importer_eori
 FROM ((SELECT item_description,
      item_product,
      item_national_additional_code,
      item_commodity_code,
      item_non_preferential_country_code,
      item_preferential_country_code,
      importer_eori,
      dwh_src_file_name,
      dwh_src_1_tmsp,
      dwh_src_1_tmsp AS dwh_mapping_tmsp,
      0 AS tf_error_fg,
      0 AS deleted_fg,
      0 AS record_id,
      dwh_src_file_name AS filename
     FROM szd_production_etl.t_cache_ceva_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_product, item_national_additional_code, item_commodity_code,
           item_non_preferential_country_code, importer_eori ORDER BY 1 IS NULL, 1)) = 1
     UNION DISTINCT
     SELECT item_description,
      item_product,
      item_national_additional_code,
      item_commodity_code,
      item_non_preferential_country_code,
      item_preferential_country_code,
      importer_eori,
      dwh_src_file_name,
      dwh_src_1_tmsp,
      dwh_src_1_tmsp AS dwh_mapping_tmsp,
      0 AS tf_error_fg,
      0 AS deleted_fg,
      0 AS record_id,
      dwh_src_file_name AS filename
     FROM szd_production_etl.t_cache_maersk_lukt_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_product, item_national_additional_code, item_commodity_code,
           item_non_preferential_country_code, importer_eori ORDER BY 1 IS NULL, 1)) = 1)
    UNION DISTINCT
    SELECT item_description,
     item_product,
     item_national_additional_code,
     item_commodity_code,
     item_non_preferential_country_code,
     item_preferential_country_code,
     importer_eori,
     dwh_src_file_name,
     dwh_src_1_tmsp,
     dwh_src_1_tmsp AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     dwh_src_file_name AS filename
    FROM szd_production_etl.t_cache_maersk_lgb_2
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_product, item_national_additional_code, item_commodity_code,
          item_non_preferential_country_code, importer_eori ORDER BY 1 IS NULL, 1)) = 1) AS t5);