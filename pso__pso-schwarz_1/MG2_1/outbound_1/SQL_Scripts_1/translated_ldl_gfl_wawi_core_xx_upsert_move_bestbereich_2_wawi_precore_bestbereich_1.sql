TRUNCATE TABLE   ${temp_db}.t_wawi_precore_${src_input_table};

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  bestbereichnr,
  bestbereichbez,
  mde_nr,
  sofortdruck,
  gruppenwechsel,
  ausgabepdlk,
  datum,
  bediener,
  printer_no,
  delivery_note,
  plausibilitycheck,
  storageplcheck,
  order_stock,
  nullsetcheck,
  onlydeliverynote,
  usedbywamas,
  edelivery_note,
  ddelivery_note,
  order_scheme_active,
  order_scheme_group,
  scn,
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
  left(ctrcode, 2) AS ctrcode,
  bestbereichnr AS bestbereichnr,
  bestbereichbez AS bestbereichbez,
  mde_nr AS mde_nr,
  sofortdruck AS sofortdruck,
  gruppenwechsel AS gruppenwechsel,
  ausgabepdlk AS ausgabepdlk,
  datum AS datum,
  bediener AS bediener,
  printer_no AS printer_no,
  delivery_note AS delivery_note,
  plausibilitycheck AS plausibilitycheck,
  storageplcheck AS storageplcheck,
  order_stock AS order_stock,
  nullsetcheck AS nullsetcheck,
  onlydeliverynote AS onlydeliverynote,
  usedbywamas AS usedbywamas,
  edelivery_note AS edelivery_note,
  ddelivery_note AS ddelivery_note,
  order_scheme_active AS order_scheme_active,
  order_scheme_group AS order_scheme_group,
  scn AS scn,
  extraction_tmsp AS extraction_tmsp,
  'WAWI_HQ' AS source_system,
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ${temp_db}.${src_input_table} AS src
INNER JOIN etl.wawi_control_table_1 AS ctrl
  ON TRUE
  AND ctrl.source_table_name = upper('${TEMP_DB}.${SRC_INPUT_TABLE}')
  AND ctrl.source_status = 'A'
  AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
QUALIFY
  row_number() OVER (
    PARTITION BY left(src.ctrcode, 2), bestbereichnr
    ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
  ) = 1;