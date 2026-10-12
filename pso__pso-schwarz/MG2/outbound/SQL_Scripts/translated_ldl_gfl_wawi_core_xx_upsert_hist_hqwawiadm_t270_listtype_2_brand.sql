
--brand_type_cd,


--SUBSTR( c270_listdescript, position(' ', c270_listdescript, 1)+1) as brand_type_cd,


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename, brand_name)
(SELECT DISTINCT 'WAWI-EKS' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI-EKS' AS source_system,
  CAST(lis.extraction_tmsp AS DATE) AS extraction_dt,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(lis.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  '${SRC_INPUT_TABLE}' AS filename,
  UPPER(lis.marke) AS brand_name
 FROM hqwawiadm.artikel AS art
  INNER JOIN hqwawiadm.t270_listtype AS lis ON lis.c270_listnr = lis.listenknznr
 WHERE lis.marke IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY brand_name ORDER BY lis.listenknznr IS NULL, lis.listenknznr)) = 1);