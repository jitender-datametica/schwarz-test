
TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t007_descriptions_1;


--


--


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, ctrcode, extraction_tmsp, scn, eks_link, type_,
 `desc`, code, moduser, id, moddate, readonly)
(SELECT 'WAWI' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  LEFT(src.ctrcode, 2) AS ctrcode,
  src.extraction_tmsp,
  src.scn,
  src.c007_eks_link,
  src.c007_type,
  src.c007_desc,
  src.c007_code,
  src.c007_moduser,
  CAST(src.c007_id AS STRING) AS c007_id,
  src.c007_moddate,
  src.c007_readonly
 FROM ${temp_db}.${src_input_table} AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(src.ctrcode, 2), src.c007_type, src.c007_code ORDER BY src.extraction_tmsp
       IS NULL DESC, src.extraction_tmsp DESC)) = 1);