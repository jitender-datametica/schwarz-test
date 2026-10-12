TRUNCATE TABLE   ldl_data_production.${target_db}.${tgt_target_table};

INSERT INTO ldl_data_production.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  wh_nr,
  id,
  lagerortnr,
  gesellschaftsnr,
  statussatz,
  krednr,
  po_nr,
  wedatum,
  wareneingangszeit,
  lieferscheinnr,
  we_art,
  status_1,
  tgstatus,
  wekorrdatum,
  issue_slip,
  delnotenorm,
  old_wekorrdatum,
  terminaljob_id,
  integra_adhoc_id,
  ewm_refnr,
  scn,
  storenr,
  extraction_tmsp,
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
  left(src.ctrcode, 2) AS ctrcode, /* ------------------------------ */
  wh_nr,
  id,
  lagerortnr,
  gesellschaftsnr,
  statussatz,
  krednr,
  po_nr,
  wedatum,
  wareneingangszeit,
  lieferscheinnr,
  we_art,
  status_1,
  tgstatus,
  wekorrdatum,
  issue_slip,
  delnotenorm,
  old_wekorrdatum,
  terminaljob_id,
  integra_adhoc_id,
  ewm_refnr,
  scn,
  storenr,
  extraction_tmsp,
  'WAWI' AS source_system, /* ------------------------------ */
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  CAST('0' AS NUMERIC) AS tf_error_fg,
  CAST('0' AS NUMERIC) AS deleted_fg,
  CAST('0' AS NUMERIC) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ldl_data_production.${temp_db}.${src_input_table} AS src
INNER JOIN ldl_data_production.etl.wawi_control_table_1 AS ctrl
  ON TRUE
  AND ctrl.source_table_name = upper(
    'LDL_DATA_PRODUCTION.${TEMP_DB}.${SRC_INPUT_TABLE}'
  )
  AND ctrl.source_status = 'A'
  AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
QUALIFY
  row_number() OVER (
    PARTITION BY ctrcode, id, lagerortnr, gesellschaftsnr
    ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
  ) = CAST('1' AS NUMERIC);