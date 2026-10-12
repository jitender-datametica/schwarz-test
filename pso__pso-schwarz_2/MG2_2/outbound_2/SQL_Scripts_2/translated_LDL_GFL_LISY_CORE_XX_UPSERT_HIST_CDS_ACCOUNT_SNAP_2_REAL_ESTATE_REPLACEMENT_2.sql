
BEGIN TRANSACTION;


/* Create a lookup table for the replacement accounts */


// only real estate associated with stores have replacements


// (only objects with assigned object number should be kept)


-- e.g. Records with NULL accountid's, or NULL IGL_NUMBERs


INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, source_system,
 extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, real_estate_key_type_cd, real_estate_nk,
 replacement_real_estate_nk, real_estate_replacement_type_cd, replacement_real_estate_key_type_cd)
WITH repl AS (SELECT accountid,
      igl_isocode2 || '|' || LTRIM(SUBSTR(igl_number, 3, 7), '0#') AS real_estate_replacement_nk,
    igl_expectedopeningdate,
    igl_neodate
   FROM ldl_data_production_etl_process.${t_src_input_table} AS drv
   WHERE accountid IN (SELECT igl_replacementid
      FROM ldl_data_production_etl_process.${t_src_input_table} AS sub
      WHERE igl_accounttypecode = 285540000
       AND deleted <> 'x'
       AND (igl_neodate IS NOT NULL OR igl_expectedopeningdate IS NOT NULL)
       AND igl_replacementid IS NOT NULL
       AND igl_number IS NOT NULL)) (SELECT 'LISY' AS dwh_node_cd,
    0 AS tf_error_fg,
    '${LOAD_ID}' AS dwh_load_id,
    'LISY' AS source_system,
    CURRENT_DATE AS extraction_dt,
    CAST(0 AS BOOL) AS deleted_fg,
    CAST(0 AS STRING) AS record_id,
    CAST(CASE
      WHEN t3.igl_neodate IS NOT NULL
      THEN t3.igl_neodate
      WHEN CAST(t3.igl_expectedopeningdate AS DATE) > CURRENT_DATE AND t3.igl_neodate IS NULL
      THEN t3.igl_expectedopeningdate
      ELSE src.sinkmodifiedon
      END AS TIMESTAMP) AS dwh_valid_from_tmsp,
    '${t_SRC_INPUT_TABLE}' AS filename,
    'RE_2' AS real_estate_key_type_cd,
      src.igl_isocode2 || '|' || LTRIM(SUBSTR(src.igl_number, 3, 7), '0#') AS real_estate_nk,
     CASE
     WHEN t3.real_estate_replacement_nk IS NULL
     THEN 'DUMMY_2|DUMMY_2'
     ELSE t3.real_estate_replacement_nk
     END AS replacement_real_estate_nk,
     CASE
     WHEN src.igl_projecttypecode = 285540001
     THEN 'RECON'
     ELSE 'RELOC'
     END AS real_estate_replacement_type_cd,
     CASE
     WHEN t3.real_estate_replacement_nk IS NULL
     THEN 'DUMMY_2'
     ELSE 'RE_2'
     END AS replacement_real_estate_key_type_cd
   FROM ldl_data_production_etl_process.${t_src_input_table} AS src
    LEFT JOIN repl AS t3 ON src.igl_replacementid = t3.accountid
   WHERE src.igl_accounttypecode = 285540000
    AND src.deleted <> 'x'
    AND src.igl_number IS NOT NULL
    AND src.igl_replacementid IS NOT NULL
    AND t3.real_estate_replacement_nk IS NOT NULL);


COMMIT