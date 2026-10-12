
TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t920_delitems_1;


--------------------------------


--------------------------------


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, ctrcode, extraction_tmsp, scn, c920_itemnr_short
 , c920_moduser, c920_itemdesc, c920_batchitemnr, c920_errortable, c920_moddate, c920_error_message, c920_created_by,
 c920_released_by, c920_batchnr, c920_batchdate, c920_closed, c920_idvalue, c920_state)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
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
  src.c920_itemnr_short,
  src.c920_moduser,
  CAST(NULL AS STRING) AS c920_itemdesc,
  src.c920_batchitemnr,
  src.c920_errortable,
  src.c920_moddate,
  src.c920_error_message,
  src.c920_created_by,
  src.c920_released_by,
  src.c920_batchnr,
  src.c920_batchdate,
  src.c920_closed,
  src.c920_idvalue,
  src.c920_state
 FROM ldl_data_production_etl.t920_delitems_1 AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('etl.t920_delitems_1')
    AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(src.ctrcode, 2), src.c920_batchnr, src.c920_batchitemnr ORDER BY src.extraction_tmsp
       IS NULL DESC, src.extraction_tmsp DESC)) = 1);