 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , prod_key_type_cd, int_org_key_type_cd, party_nat_key_nr,
 -- FRAMEWORK AND TECHNICAL COLUMNS
  prod_nat_key_nr, prod_status_categ_cd, prod_status_type_cd)
(SELECT 'WH_WAWIADM' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS prod_key_type_cd,
  'COMPANY' AS int_org_key_type_cd,
    ctrcode || '|' || CAST(warehouseno AS STRING) AS party_nat_key_nr,
    LTRIM(ctrcode, '0') || '|' || CAST(itemno AS STRING) AS prod_nat_key_nr,
  'WAWI_PROD_LIFECYCLE' AS prod_status_categ_cd,
  CAST(status AS STRING) AS prod_status_type_cd
 FROM (SELECT DISTINCT ctrcode,
    itemno,
    warehouseno,
    status
   FROM ${temp_db}.t_${src_input_table}) AS src);