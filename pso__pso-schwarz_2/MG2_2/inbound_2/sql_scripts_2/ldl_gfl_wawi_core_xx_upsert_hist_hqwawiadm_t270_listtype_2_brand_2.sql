INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  brand_name,
  --brand_type_cd,
  source_system,
  extraction_dt,  
  dwh_mapping_tmsp,  
  tf_error_fg, 
  deleted_fg, 
  record_id, 
  filename,
  dwh_node_cd, 
  dwh_load_id)
SELECT	DISTINCT
  UPPER(marke) brand_name,
  --SUBSTR( c270_listdescript, position(' ', c270_listdescript, 1)+1) as brand_type_cd,
  'WAWI-EKS' source_system,
  lis.extraction_tmsp extraction_dt,
  lis.extraction_tmsp dwh_mapping_tmsp,
  0 tf_error_fg,
  0 deleted_fg,
  0 record_id,
  '${SRC_INPUT_TABLE}' filename,
  'WAWI-EKS' dwh_node_cd,
  '${LOAD_ID}' dwh_load_id 
FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.artikel_2 art_2
JOIN ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.hqwawiadm.t270_listtype_2 lis ON  c270_listnr = listenknznr
WHERE marke is NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY UPPER(marke) ORDER BY listenknznr ASC ) = 1;

