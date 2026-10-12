
TRUNCATE TABLE ${dm_inferred_target_db}.${tgt_target_table};


--


--


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, ctrcode, wh_nr, extraction_tmsp, scn, moduser,
 moddate, itemno, locked, warehouseno)
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
  src.wh_nr,
  src.extraction_tmsp,
  src.scn,
  src.c119_moduser,
  src.c119_moddate,
  CAST(src.c119_itemno AS INTEGER) AS c119_itemno,
  src.c119_locked,
  src.c119_warehouseno
 FROM ${temp_db}.${src_input_table} AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(src.ctrcode, 2), src.c119_itemno, src.c119_warehouseno ORDER BY src.extraction_tmsp
       IS NULL DESC, src.extraction_tmsp DESC)) = 1);