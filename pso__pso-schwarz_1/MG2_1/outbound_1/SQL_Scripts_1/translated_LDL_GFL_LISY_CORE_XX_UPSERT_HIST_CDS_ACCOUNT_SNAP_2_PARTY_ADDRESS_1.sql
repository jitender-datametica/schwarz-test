
INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (addr_key_type_cd, dwh_node_cd, tf_error_fg,
 party_natural_key, addr_natural_key, dwh_load_id, source_system, party_key_type_cd, addr_type_cd, extraction_dt,
 deleted_fg, addr_usg_type_cd, party_type_cd, record_id, dwh_mapping_tmsp, filename)
(SELECT addr_key_type_cd,
  dwh_node_cd,
  tf_error_fg,
  party_natural_key,
  addr_natural_key,
  dwh_load_id,
  source_system,
  party_key_type_cd,
  addr_type_cd,
  extraction_dt,
   deleted_fg <> 0 AS deleted_fg,
  addr_usg_type_cd,
  party_type_cd,
  CAST(record_id AS STRING) AS record_id,
  CAST(dwh_valid_from_tmsp AS TIMESTAMP) AS dwh_valid_from_tmsp,
  filename
 FROM (SELECT 'STORE' AS party_key_type_cd,
       igl_isocode2 || '|' || LTRIM(SUBSTR(igl_number, 3, LENGTH(igl_number)), '0#') AS party_natural_key,
     'STAD' AS addr_key_type_cd,
                   COALESCE(igl_isocode2, '') || '|' || COALESCE(address1_city, '') || '|' || COALESCE(igl_ortsteil, ''
                 ) || '|' || COALESCE(address1_postalcode, '') || '|' || COALESCE(address1_line1, '') || '|' || COALESCE(address1_line2
           , '') || '|' || CAST(IFNULL(address1_longitude, 0) AS STRING) || '|' || CAST(IFNULL(address1_latitude, 0) AS STRING)
       AS addr_natural_key,
     'SA_MN' AS addr_usg_type_cd,
     'INT_ORG' AS party_type_cd,
     'STAD' AS addr_type_cd,
     'LISY' AS source_system,
     CURRENT_DATE AS extraction_dt,
      CASE
      WHEN igl_neodate IS NOT NULL
      THEN igl_neodate
      ELSE sinkmodifiedon
      END AS dwh_valid_from_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${T_SRC_INPUT_TABLE}' AS filename,
     'LISY' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ldl_data_production_etl_process.${t_src_input_table} AS src
    WHERE igl_accounttypecode IN (285540000, 285540009)
     AND (igl_neodate IS NOT NULL OR igl_closingdate IS NOT NULL)
     AND deleted <> 'x'
     AND igl_number IS NOT NULL
     AND igl_isocode2 IS NOT NULL
    UNION ALL
    SELECT 'STORE' AS party_key_type_cd,
       igl_isocode2 || '|' || LTRIM(SUBSTR(igl_number, 3, LENGTH(igl_number)), '0#') AS party_natural_key,
     'TEL' AS addr_key_type_cd,
       igl_isocode2 || '|' || address1_telephone2 AS addr_natural_key,
     'TL_MN' AS addr_usg_type_cd,
     'INT_ORG' AS party_type_cd,
     'TEL' AS addr_type_cd,
     'LISY' AS source_system,
     CURRENT_DATE AS extraction_dt,
      CASE
      WHEN igl_neodate IS NOT NULL
      THEN igl_neodate
      ELSE sinkmodifiedon
      END AS dwh_valid_from_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${T_SRC_INPUT_TABLE}' AS filename,
     'LISY' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ldl_data_production_etl_process.${t_src_input_table} AS src
    WHERE igl_accounttypecode IN (285540000, 285540009)
     AND (igl_neodate IS NOT NULL OR igl_closingdate IS NOT NULL)
     AND deleted <> 'x'
     AND igl_number IS NOT NULL
     AND igl_isocode2 IS NOT NULL
     AND address1_telephone2 IS NOT NULL) AS t3);