
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, curr_cd, inv_stat_val, inv_stat_type_cd,
 inv_key_type_cd, inv_natural_key)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS source_system,
  CAST(src.extraction_tmsp AS DATE) AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  org.curr_cd,
   CASE
   WHEN stat.inv_stat_type_cd = 'TURNOVER'
   THEN src.c438_turnover
   WHEN stat.inv_stat_type_cd = 'DIFF'
   THEN src.c438_diffvalue
   ELSE NULL
   END AS stat_val,
  stat.inv_stat_type_cd,
  'PART' AS inv_key_type_cd,
      src.ctrcode || '|' || CAST(src.wh_nr AS STRING) || '|' || CAST(src.c438_inv_id AS STRING) AS inv_natural_key
 FROM ldl_data_production_etl_process.${t_src_input_table} AS src
  INNER JOIN ${temp_db}.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('${TEMP_DB}.t438_part_inv_head_wh_1'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
  INNER JOIN ldl_data_production_meta.t_party_key_1 AS pk ON src.party_key_type_cd = 'COUNTRY_1' AND src.party_nat_key_nr =
     src.ctrcode AND pk.dwh_valid_fg
  LEFT JOIN ldl_data_production_core_rel.t_internal_organization_1 AS org ON src.int_org_sid = pk.party_sid AND org.dwh_valid_fg
   
  INNER JOIN (SELECT 'TURNOVER' AS inv_stat_type_cd
    UNION ALL
    SELECT 'DIFF' AS inv_stat_type_cd) AS stat ON TRUE);