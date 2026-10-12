
TRUNCATE TABLE ${dm_inferred_target_db}.${tgt_target_table};


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (tf_error_fg, dwh_load_id, deleted_fg, record_id,
 filename, source_system, extraction_dt, dwh_mapping_tmsp, ctrcode, extraction_tmsp, scn, location, packageid,
 itemgroupid, protno, itemno, casesize, c026_item_weight_information, branddesc, itemtypeid, insertdate, action_flag,
 unitid, bundlefact, itemgrshortdesc, volume, seqid, itemgrdesc, transferflag, countrycode, bitflag, itemdesc, posno,
 transferdate)
(SELECT 0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  LEFT(src.ctrcode, 2) AS ctrcode,
  src.extraction_tmsp,
  src.scn,
  src.location,
  src.packageid,
  src.itemgroupid,
  src.protno,
  src.itemno,
  src.casesize,
  src.c026_item_weight_information,
  src.branddesc,
  src.itemtypeid,
  MIN(src.insertdate) OVER (PARTITION BY src.itemno RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
  insertdate,
  src.action_flag,
  src.unitid,
  src.bundlefact,
  src.itemgrshortdesc,
  src.volume,
  src.seqid,
  src.itemgrdesc,
  src.transferflag,
  src.countrycode,
  src.bitflag,
  src.itemdesc,
  src.posno,
  src.transferdate
 FROM ${temp_db}.${src_input_table} AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table AS ctrl ON ctrl.source_table_name = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.itemno ORDER BY src.seqid IS NULL DESC, src.seqid DESC)) = 1);