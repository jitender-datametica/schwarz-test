
-- flags are True if we have a record with this role for the company and its state is active 


-- reduce the dataset to 1 rec per Company


INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id
 , source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, party_sid, party_key_type_cd,
 party_nat_key_nr)
WITH company_countries AS (SELECT SUBSTR(igl_associationnumber, 1, 2) || '|' || CAST(ROUND(CAST(REGEXP_REPLACE(igl_associationnumber, '[^0-9]', '') AS BIGNUMERIC), 0) AS STRING)
      AS comp_nat_key_nr,
    MAX(sinkmodifiedon) AS mapping_tmsp,
    MAX(CASE
      WHEN igl_companytypecode = '285540001'
      THEN igl_isocode2
      ELSE NULL
      END) AS country_nat_key_nr,
      COUNT(CASE
        WHEN igl_companytypecode = '285540001'
        THEN 1
        ELSE NULL
        END) > 0 AND COUNT(CASE
        WHEN statecode = 0
        THEN 1
        ELSE NULL
        END) > 0 AS is_country_org_fg
   FROM ldl_data_production_etl_process.t_tcache_lisy_cds_company_snap
   WHERE SUBSTR(igl_associationnumber, 1, 2) || '|' || CAST(ROUND(CAST(REGEXP_REPLACE(igl_associationnumber, '[^0-9]', '') AS BIGNUMERIC)
        , 0) AS STRING) NOT IN ('FR|2', 'FR|1', 'SI|5', 'CZ|2', 'DE|10', 'DE|79')
   GROUP BY comp_nat_key_nr) (SELECT 'LISY' AS dwh_node_cd,
    0 AS tf_error_fg,
    '${LOAD_ID}' AS dwh_load_id,
    'LISY' AS source_system,
    CURRENT_DATE AS extraction_dt,
    CAST(0 AS BOOL) AS deleted_fg,
    CAST(0 AS STRING) AS record_id,
    CAST(SRC.mapping_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
    '${t_SRC_INPUT_TABLE}' AS filename,
    keys.party_sid,
    'COUNTRY' AS party_key_type_cd,
    SRC.country_nat_key_nr AS party_nat_key_nr
   FROM company_countries AS SRC
    INNER JOIN ldl_data_production_meta.t_party_key AS keys ON keys.party_nat_key_nr = UPPER(SRC.comp_nat_key_nr)
   WHERE keys.party_key_type_cd = 'COMPANY'
    AND keys.dwh_valid_fg
    AND SRC.is_country_org_fg);