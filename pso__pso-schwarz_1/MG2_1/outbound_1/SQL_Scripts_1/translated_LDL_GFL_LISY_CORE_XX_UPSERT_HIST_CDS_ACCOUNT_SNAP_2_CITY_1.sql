
--- ""Grossebersdorf"" is same as ""Großebersdorf"" when converted to UPPER


-- so we eliminate such duplicates of NK by taking the longer ( ""ss"" instead of ""ß"")


INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, city_key_type_cd,
 tf_error_fg, dwh_load_id, iso_country_cd, country_nat_key_nr, country_key_type_cd, source_system, extraction_dt,
 city_name, deleted_fg, city_nat_key_nr, record_id, country_name, dwh_mapping_tmsp, filename)
(SELECT 'LISY' AS dwh_node_cd,
  'CITY' AS city_key_type_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
   CASE
   WHEN src.igl_ortsteil = 'NI'
   THEN 'GB'
   ELSE src.igl_ortsteil
   END AS iso_country_cd,
  COALESCE(src.igl_ortsteil, '') AS country_nat_key_nr,
  'CTRY' AS country_key_type_cd,
  'LISY' AS source_system,
  CURRENT_DATE AS extraction_dt,
  src.igl_isocode2 AS city_name,
  CAST(0 AS BOOL) AS deleted_fg,
    COALESCE(src.igl_ortsteil, '') || '|' || COALESCE(src.igl_isocode2, '') AS city_nat_key_nr,
  CAST(0 AS STRING) AS record_id,
   CASE
   WHEN src.igl_ortsteil = 'NI'
   THEN 'Vereinigtes Königreich'
   ELSE ctry.iso_country_cd
   END AS country_name,
  CAST(src.sinkmodifiedon AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename
 FROM ldl_data_production_etl_process.${t_src_input_table} AS src
  LEFT JOIN ldl_data_production_core_rel.t_country_1 AS ctry ON src.igl_ortsteil = ctry.dwh_valid_fg
 WHERE src.address1_city <> 'x'
  AND src.igl_ortsteil IS NOT NULL
  AND src.igl_isocode2 IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.igl_ortsteil || '|' || UPPER(IFNULL(src.igl_isocode2, '')) ORDER BY LENGTH(src
          .igl_ortsteil || '|' || UPPER(IFNULL(src.igl_isocode2, ''))) IS NULL, LENGTH(src.igl_ortsteil || '|' || UPPER(IFNULL(src
           .igl_isocode2, ''))), src.sinkmodifiedon IS NULL DESC, src.sinkmodifiedon DESC)) = 1);