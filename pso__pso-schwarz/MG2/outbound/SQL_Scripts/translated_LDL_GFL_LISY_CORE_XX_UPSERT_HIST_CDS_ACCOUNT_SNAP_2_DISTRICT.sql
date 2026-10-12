
--- ""Grossebersdorf"" is same as ""Großebersdorf"" when converted to UPPER


-- so we eliminate such duplicates of NK by taking the longer ( ""ss"" instead of ""ß"")


INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (district_key_type_cd, dwh_node_cd,
 city_key_type_cd, tf_error_fg, dwh_load_id, iso_country_cd, country_nat_key_nr, country_key_type_cd, source_system,
 district_name, extraction_dt, city_name, deleted_fg, district_nat_key_nr, city_nat_key_nr, record_id, country_name,
 dwh_mapping_tmsp, filename)
(SELECT 'DSTR' AS district_key_type_cd,
  'LISY' AS dwh_node_cd,
  'CITY' AS city_key_type_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
   CASE
   WHEN src.igl_isocode2 = 'NI'
   THEN 'GB'
   ELSE src.igl_isocode2
   END AS iso_country_cd,
  COALESCE(src.igl_isocode2, '') AS country_nat_key_nr,
  'CTRY' AS country_key_type_cd,
  'LISY' AS source_system,
  src.igl_ortsteil AS district_name,
  CURRENT_DATE AS extraction_dt,
  src.address1_city AS city_name,
  CAST(0 AS BOOL) AS deleted_fg,
      COALESCE(src.igl_isocode2, '') || '|' || COALESCE(src.address1_city, '') || '|' || COALESCE(src.igl_ortsteil, '')
  AS district_nat_key_nr,
    COALESCE(src.igl_isocode2, '') || '|' || COALESCE(src.address1_city, '') AS city_nat_key_nr,
  CAST(0 AS STRING) AS record_id,
   CASE
   WHEN src.igl_isocode2 = 'NI'
   THEN 'Vereinigtes Königreich'
   ELSE ctry.country_name
   END AS country_name,
  CAST(src.sinkmodifiedon AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename
 FROM ldl_data_production_etl_process.${t_src_input_table} AS src
  LEFT JOIN ldl_data_production_core_rel.t_country AS ctry ON src.igl_isocode2 = ctry.iso_country_cd
 WHERE src.deleted <> 'x'
  AND src.igl_isocode2 IS NOT NULL
  AND src.address1_city IS NOT NULL
  AND src.igl_ortsteil IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.igl_isocode2 || '|' || UPPER(IFNULL(src.address1_city, '')) || '|' ||
        UPPER(IFNULL(src.igl_ortsteil, '')) ORDER BY LENGTH(src.igl_isocode2 || '|' || UPPER(IFNULL(src.address1_city,
             '')) || '|' || UPPER(IFNULL(src.igl_ortsteil, ''))) IS NULL, LENGTH(src.igl_isocode2 || '|' || UPPER(IFNULL(src
             .address1_city, '')) || '|' || UPPER(IFNULL(src.igl_ortsteil, ''))), src.sinkmodifiedon IS NULL DESC, src.sinkmodifiedon
       DESC)) = 1);