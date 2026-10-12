INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  packing_type_cd,
  packing_type_descr,
  packing_type_descr_en,
  packing_type_descr_de,
  dwh_load_id,
  dwh_node_cd,
  tf_error_fg,
  error_descr,
  record_id,
  filename
)

SELECT 
  packing_type_cd,
  MAX(CASE WHEN lang_cd ='DE' THEN packing_type_descr ELSE '' END) AS packing_type_descr,
  MAX(CASE WHEN lang_cd ='EN' THEN packing_type_descr ELSE '' END) AS packing_type_descr_en,
  MAX(CASE WHEN lang_cd ='DE' THEN packing_type_descr ELSE '' END) AS packing_type_descr_de,
  ${LOAD_ID} dwh_load_id,
  dwh_node_cd dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'core_rel' filename
FROM core_rel.t_packing_type
GROUP BY packing_type_cd,dwh_load_id,dwh_node_cd,tf_error_fg,error_descr,record_id,filename;

