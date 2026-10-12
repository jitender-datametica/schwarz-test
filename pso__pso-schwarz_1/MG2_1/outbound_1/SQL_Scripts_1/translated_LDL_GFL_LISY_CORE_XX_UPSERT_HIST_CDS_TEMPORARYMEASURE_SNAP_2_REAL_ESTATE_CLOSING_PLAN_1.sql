
-- real estate associated with stores and special sale stores,


-- (only objects with assigned object number should be kept)


-- we are interested in all closing times of stores regardless of the concrete measure.


INSERT INTO ldl_data_production_etl.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, source_system,
 extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, real_estate_key_type_cd, real_estate_nk,
 closed_from_dt, closed_until_dt, closed_bus_days_cnt)
(SELECT 'LISY' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'LISY' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'RE_1' AS real_estate_key_type_cd,
    igl_isocode2 || '|' || LTRIM(SUBSTR(igl_number, 3, 7), '0#') AS real_estate_nk,
  DATE(SAFE.PARSE_DATETIME('%Y%m%d', igl_closingdatefrom)) AS closed_from_dt,
   CASE
   WHEN igl_closingdateto IS NOT NULL
   THEN DATE(SAFE.PARSE_DATETIME('%Y%m%d', igl_closingdateto))
   WHEN igl_closingdateto IS NULL AND igl_reopeningdate IS NOT NULL
   THEN DATE_SUB(DATE(SAFE.PARSE_DATETIME('%Y%m%d', igl_reopeningdate)), INTERVAL 1 DAY)
   ELSE NULL
   END AS closed_until_dt,
   CASE
   WHEN igl_closingdateto IS NOT NULL
   THEN DATE_DIFF(DATE(SAFE.PARSE_DATETIME('%Y%m%d', igl_closingdateto)), DATE(SAFE.PARSE_DATETIME('%Y%m%d',
      igl_closingdatefrom)), DAY)
   WHEN igl_closingdateto IS NULL AND igl_reopeningdate IS NOT NULL
   THEN DATE_DIFF(DATE_SUB(DATE(SAFE.PARSE_DATETIME('%Y%m%d', igl_reopeningdate)), INTERVAL 1 DAY), DATE(SAFE.PARSE_DATETIME('%Y%m%d'
      , igl_closingdatefrom)), DAY)
   ELSE NULL
   END AS closed_bus_days_cnt
 FROM ldl_data_production_etl_process.${t_src_input_table} AS src
 WHERE igl_accounttypecode IN (285540000, 285540009)
  AND (igl_closingdateto IS NOT NULL OR igl_reopeningdate > igl_closingdatefrom)
  AND igl_number IS NOT NULL
  AND igl_closingdatefrom IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY igl_closingdatefrom ORDER BY extraction_ts IS NULL DESC, extraction_ts DESC))
   = 1);