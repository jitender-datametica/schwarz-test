INSERT INTO ldl_data_production.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  inv_key_type_cd,
  inv_natural_key,
  inv_dt,
  inv_type_cd,
  inv_nr,
  int_org_key_type_cd,
  int_org_natural_key,
  int_org_type_cd,
  country_org_cd,
  country_org_natural_key,
  country_org_key_type_cd,
  inv_period_start_dt,
  inv_period_end_dt,
  inv_reason_id,
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
  'PART' AS inv_key_type_cd,
  CONCAT(o.country_org_cd, '|', src.wh_nr, '|', c438_inv_id) AS inv_natural_key,
  c438_inventorydate AS inv_dt,
  'PART' AS inv_type_cd,
  c438_inv_id AS inv_nr,
  'STORE' AS int_org_key_type_cd,
  CONCAT(o.country_org_cd, '|', c438_storenr) AS int_org_natural_key,
  'STORE' AS int_org_type_cd,
  o.country_org_cd AS country_org_cd,
  o.country_org_cd AS country_org_natural_key,
  'COUNTRY_1' AS country_org_key_type_cd,
  c438_inventorydate AS inv_period_start_dt,
  c438_inventorydate AS inv_period_end_dt,
  c438_inv_type AS inv_reason_id,
  'WAWI_WH' AS source_system,
  extraction_tmsp AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  CAST('0' AS NUMERIC) AS tf_error_fg,
  CAST('0' AS NUMERIC) AS deleted_fg,
  CAST('0' AS NUMERIC) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ldl_data_production.${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_1 AS co
  ON co.schema_name = upper('whwawistd')
  AND co.table_name = upper('t438_part_inv_head_1')
INNER JOIN ldl_data_production.etl_process.t_wawi_extract_control_status_1 AS st
  ON st.schema_name = upper('whwawistd')
  AND st.table_name = upper('t438_part_inv_head_1')
  AND ai_graph_name = '${AI_GRAPH_NAME}'
  AND src.wawi_instanz_kzl = st.wawi_instanz_kzl
  AND src.wh_nr = st.wh_nr
  AND src.scn >= IF(co.delta_fg, st.last_scn, CAST('0' AS NUMERIC))
INNER JOIN ldl_data_production.meta.t_party_key_1 AS k
  ON left(src.wawi_instanz_kzl, 2) = k.party_nat_key_nr
  AND k.dwh_valid_fg
  AND k.party_key_type_cd = 'COUNTRY_1'
INNER JOIN ldl_data_production.core_rel.t_internal_organization_1 AS o
  ON k.party_sid = o.int_org_sid AND o.dwh_valid_fg
WHERE
  delete_fg IS NULL
QUALIFY
  row_number() OVER (
    PARTITION BY src.wawi_instanz_kzl, src.wh_nr, c438_inv_id
    ORDER BY IF(extraction_tmsp IS NULL, 0, 1), extraction_tmsp DESC
  ) = CAST('1' AS NUMERIC);