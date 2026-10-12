
-- ""Grossebersdorf"" is same as ""Großebersdorf"" when converted to UPPER


-- so we eliminate such duplicates of NK by taking the longer ( ""ss"" instead of ""ß"")


INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (district_key_type_cd, dwh_node_cd,
 city_key_type_cd, tf_error_fg, dwh_load_id, iso_country_cd, country_key_type_cd, source_system, extraction_dt,
 city_name, deleted_fg, record_id, country_name, dwh_mapping_tmsp, filename, igl_isocode2, zip, igl_city,
 reporting_country_cd, street_name, district_nk, street_addr_nk, street_addr_key_type_cd, reporting_country_key_type_cd
 , postal_cd_area_key_type_cd, house_nr)
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
  'CTRY' AS country_key_type_cd,
  'LISY' AS source_system,
  CURRENT_DATE AS extraction_dt,
  src.igl_city AS city_name,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
   CASE
   WHEN src.igl_isocode2 = 'NI'
   THEN 'Vereinigtes Königreich'
   ELSE ctry.country_name
   END AS country_name,
  src.extraction_ts AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  src.igl_isocode2,
  src.igl_postalcode AS zip,
  src.igl_city,
  src.igl_isocode2 AS reporting_country_cd,
  src.igl_street AS street_name,
  CAST(NULL AS STRING) AS district_nk,
          COALESCE(src.igl_isocode2, '') || '|' || COALESCE(src.igl_city, '') || '|' || COALESCE(src.igl_postalcode, ''
        ) || '|' || COALESCE(src.igl_street, '') || '|' || COALESCE(src.igl_housenumber, '') AS street_addr_nk,
  'STAD' AS street_addr_key_type_cd,
  'REP_CTRY' AS reporting_country_key_type_cd,
  'ZIP' AS postal_cd_area_key_type_cd,
  src.igl_housenumber AS house_nr
 FROM ldl_data_production_etl_process.${t_src_input_table} AS src
  LEFT JOIN ldl_data_production_core_rel.t_country_2 AS ctry ON src.igl_isocode2 = ctry.iso_country_cd
 WHERE src.deleted <> 'x'
  AND src.igl_isocode2 IS NOT NULL
  AND src.igl_city IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.igl_isocode2 || '|' || UPPER(IFNULL(src.igl_city, '')) || '|' || UPPER(IFNULL(src
              .igl_postalcode, '')) || '|' || UPPER(IFNULL(src.igl_street, '')) || '|' || UPPER(IFNULL(src.igl_housenumber
          , '')) ORDER BY LENGTH(src.igl_isocode2 || '|' || UPPER(IFNULL(src.igl_city, '')) || '|' || UPPER(IFNULL(src.igl_postalcode
               , '')) || '|' || UPPER(IFNULL(src.igl_street, '')) || '|' || UPPER(IFNULL(src.igl_housenumber, '')))
       IS NULL, LENGTH(src.igl_isocode2 || '|' || UPPER(IFNULL(src.igl_city, '')) || '|' || UPPER(IFNULL(src.igl_postalcode
               , '')) || '|' || UPPER(IFNULL(src.igl_street, '')) || '|' || UPPER(IFNULL(src.igl_housenumber, ''))), src
       .sinkmodifiedon IS NULL DESC, src.sinkmodifiedon DESC)) = 1);