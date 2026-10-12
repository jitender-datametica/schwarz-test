INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  uom_cd,
  uom_name,
  uom_name_en,
  uom_name_de,
  dwh_load_id,
  dwh_node_cd,
  tf_error_fg,
  error_descr,
  record_id,
  filename
)

SELECT 
  uom_cd,
  MAX(CASE WHEN lang_cd ='DE' THEN uom_name ELSE '' END) AS uom_name,
  MAX(CASE WHEN lang_cd ='EN' THEN uom_name ELSE '' END) AS uom_name_en,
  MAX(CASE WHEN lang_cd ='DE' THEN uom_name ELSE '' END) AS uom_name_de,
  ${LOAD_ID} dwh_load_id,
  dwh_node_cd dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'core_rel' filename
FROM core_rel.t_unit_of_measure_1
GROUP BY uom_cd,dwh_load_id,dwh_node_cd,tf_error_fg,error_descr,record_id,filename
UNION
SELECT 
  '@',
  'Unbekannt',
  'Unbekannt',
  'Unknown',
  ${LOAD_ID} dwh_load_id,
  'MANUAL' dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'core_rel' filename;
