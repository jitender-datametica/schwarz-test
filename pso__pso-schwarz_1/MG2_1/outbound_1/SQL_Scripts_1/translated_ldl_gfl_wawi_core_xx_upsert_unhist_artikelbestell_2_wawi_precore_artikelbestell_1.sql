TRUNCATE TABLE   ${target_db}.${tgt_target_table};

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  artikelnr,
  disponr,
  palettenschein,
  mhdpruefung,
  autobestell,
  best_fuehr,
  gewicht,
  zusatz,
  dispoknz,
  commoditycode,
  dispo_period,
  lieferzeit,
  mindbestwoche,
  datum,
  bediener,
  dispogrupnr,
  gewichtsartikel,
  order_only,
  itemstatus_1,
  direct_delivery,
  dispobkp,
  avg_forced,
  filling_qty,
  artikel_info,
  promo_menge,
  promo_ende,
  manueller_abgang,
  sollrwg,
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
  left(src.ctrcode, 2) AS ctrcode, /* ------------------------------ */
  artikelnr,
  disponr,
  palettenschein,
  mhdpruefung,
  autobestell,
  best_fuehr,
  gewicht,
  zusatz,
  NULL AS dispoknz,
  commoditycode,
  dispo_period,
  lieferzeit,
  mindbestwoche,
  datum,
  bediener,
  dispogrupnr,
  gewichtsartikel,
  order_only,
  itemstatus_1,
  direct_delivery,
  dispobkp,
  avg_forced,
  filling_qty,
  artikel_info,
  promo_menge,
  promo_ende,
  manueller_abgang,
  sollrwg,
  scn,
  extraction_tmsp,
  'WAWI' AS source_system, /* ------------------------------ */
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
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
    PARTITION BY ctrcode, artikelnr
    ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
  ) = 1;