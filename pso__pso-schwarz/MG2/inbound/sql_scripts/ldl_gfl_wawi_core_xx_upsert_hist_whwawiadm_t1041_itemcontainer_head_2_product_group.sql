INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  prod_grp_key_type_cd,
  prod_grp_key_nr,
  prod_grp_type_cd,
  prod_grp_nr,
  prod_grp_name,
  prod_container_type_cd,
  prod_container_class_cd,
  prod_container_assort_area_cd,
  prod_container_size_cd,
  country_org_sid,

   -- framework and technical columns
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
SELECT 
  'Container' as prod_grp_key_type_cd,
  c1041_country || '|' || c1041_cont_id_local as prod_grp_key_nr,
  'PC' as prod_grp_type_cd,
  c1041_cont_id_local AS prod_grp_nr,
  c1041_desc_nat AS prod_grp_name,
  CASE WHEN c1041_desc_int='INT' THEN 'INT' 
       ELSE 'LOC'
  END AS prod_container_type_cd,
  CASE WHEN SPLIT_PART(c1041_desc_int,' ',1) IN  ('MC','FC','TC') THEN SPLIT_PART(c1041_desc_int,' ',1)
       ELSE NULL
  END AS prod_container_class_cd,
  c1041_country || '|' || c1041_cont_id_local AS prod_container_assort_area_cd,
  CASE WHEN SPLIT_PART(c1041_desc_int,' ',-1) IN ('XS','S','M','L','XXS','XXL')  THEN SPLIT_PART(c1041_desc_int,' ',-1)
       ELSE NULL 
  END AS prod_container_size_cd,
  party_sid AS country_org_sid,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ${LDL_WAWI_COMMON_SNFLK_CL_DB_NAME}.${SRC_INPUT_TABLE} src
LEFT OUTER JOIN meta.t_party_key p ON party_key_type_cd='COUNTRY' AND party_nat_key_nr=c1041_country AND dwh_valid_fg
WHERE C1041_STATUS='1' 
QUALIFY Row_Number() OVER (PARTITION BY C1041_COUNTRY, C1041_CONT_ID_LOCAL ORDER BY C1041_MODDATE DESC) = 1;
