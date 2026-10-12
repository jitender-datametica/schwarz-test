INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 inv_key_type_cd, inv_natural_key, inv_status_type_cd)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'WAWI_WH' AS source_system,
  CAST(src.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${SRC_INPUT_TABLE}' AS filename,
  'PART' AS inv_key_type_cd,
      o.country_org_cd || '|' || CAST(src.wh_nr AS STRING) || '|' || CAST(src.c438_inv_id AS STRING) AS inv_natural_key
  ,
  CAST(CASE
    WHEN src.c438_status = 10
    THEN - 10
    WHEN src.c438_status = 20
    THEN - 20
    WHEN src.c438_status = 99
    THEN - 99
    ELSE src.c438_status
    END AS STRING) AS inv_status_type_cd
 FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
  INNER JOIN ldl_data_production_etl_process.t_wawi_extract_control_1 AS co ON co.schema_name = UPPER('whwawistd') AND co
    .table_name = UPPER('t438_part_inv_head_1')
  INNER JOIN ldl_data_production_etl_process.t_wawi_extract_control_status_1 AS st ON st.schema_name = UPPER('whwawistd')
       AND st.table_name = UPPER('t438_part_inv_head_1') AND src.ai_graph_name = '${AI_GRAPH_NAME}' AND
      src.wawi_instanz_kzl = st.wawi_instanz_kzl AND src.wh_nr = st.wh_nr AND src.scn >= IF(co.delta_fg, st.last_scn, 0
     )
  INNER JOIN ldl_data_production_meta.t_party_key_1 AS k ON LEFT(src.wawi_instanz_kzl, 2) = k.party_nat_key_nr AND k.dwh_valid_fg
     AND k.party_key_type_cd = 'COUNTRY_1'
  INNER JOIN ldl_data_production_core_rel.t_internal_organization_1 AS o ON k.party_sid = o.int_org_sid AND o.dwh_valid_fg
   
 WHERE src.delete_fg IS NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.wawi_instanz_kzl, CAST(src.wh_nr AS STRING), src.c438_inv_id ORDER BY src
       .extraction_tmsp IS NULL DESC, src.extraction_tmsp DESC)) = 1);