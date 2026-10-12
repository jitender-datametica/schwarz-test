
TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t88_sformhead_1;


--------------------------------


--------------------------------


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, ctrcode, wh_nr, extraction_tmsp, scn,
 c88_moduser, c88_whnr, c88_global, c88_formcount, c88_towarehouse, c88_correct_count, c88_formno, c88_adr_export_date,
 c88_warehouseno, c88_pl_pv_date, c88_pl_bereich, c88_formtype, c88_adr_export_flag, c88_checksumvalue, c88_tostore,
 c88_storeno, c88_formdate, c88_moddate)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  LEFT(src.ctrcode, 2) AS ctrcode,
  src.wh_nr,
  src.extraction_tmsp,
  src.scn,
  src.c88_moduser,
  src.c88_whnr,
  src.c88_global,
  src.c88_formcount,
  src.c88_towarehouse,
  src.c88_correct_count,
  src.c88_formno,
  src.c88_adr_export_date,
  src.c88_warehouseno,
  src.c88_pl_pv_date,
  src.c88_pl_bereich,
  src.c88_formtype,
  src.c88_adr_export_flag,
  src.c88_checksumvalue,
  src.c88_tostore,
  src.c88_storeno,
  src.c88_formdate,
  src.c88_moddate
 FROM ldl_data_production_etl.t88_sformhead_1 AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('etl.t88_sformhead_1')
    AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(src.c88_formcount AS STRING), src.c88_whnr ORDER BY src.extraction_tmsp
       IS NULL DESC, src.extraction_tmsp DESC)) = 1);