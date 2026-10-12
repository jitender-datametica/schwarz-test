TRUNCATE TABLE   ldl_data_production.${target_db}.${tgt_target_table};

INSERT INTO ldl_data_production.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  wh_nr,
  c451_id,
  c451_itemnr,
  c451_itemstatus,
  c451_subitemnr,
  c451_casesize,
  c451_origin,
  c451_class,
  bkp_c451_caliber_max_tmp,
  c451_caliber_max_tmp,
  c451_caliber_min,
  c451_caliber_max,
  c451_caliber_unit,
  c451_sort,
  c451_trademark,
  c451_subitem7,
  c451_subitem8,
  c451_subitemstatus,
  c451_temp_min,
  c451_temp_max,
  c451_dispogroupnr,
  c451_dispogroupname,
  c451_moddate,
  c451_moduser,
  c451_dirty_flag,
  c451_csize_counter,
  c451_intern_id,
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
  wh_nr,
  c451_id,
  c451_itemnr,
  c451_itemstatus,
  c451_subitemnr,
  c451_casesize,
  c451_origin,
  c451_class,
  bkp_c451_caliber_max_tmp,
  c451_caliber_max_tmp,
  c451_caliber_min,
  c451_caliber_max,
  c451_caliber_unit,
  c451_sort,
  c451_trademark,
  c451_subitem7,
  c451_subitem8,
  c451_subitemstatus,
  c451_temp_min,
  c451_temp_max,
  c451_dispogroupnr,
  c451_dispogroupname,
  c451_moddate,
  c451_moduser,
  c451_dirty_flag,
  c451_csize_counter,
  c451_intern_id,
  scn,
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
FROM (
  SELECT
  FROM ldl_data_production.${temp_db}.${src_input_table} AS ${src_input_table}_inner
  WHERE
    NOT CAST(src.c451_itemnr AS BIGNUMERIC) IN (
      SELECT
        CAST(itemno AS BIGNUMERIC)
      FROM ldl_data_production.${temp_db}.t_wawi_precore_t026_wawi_item_1
      WHERE
        NOT itemgrshortdesc BETWEEN CAST('10' AS NUMERIC) AND CAST('13' AS NUMERIC)
    )
) AS src
INNER JOIN ldl_data_production.etl.wawi_control_table_1 AS ctrl
  ON TRUE
  AND ctrl.source_table_name = upper(
    'LDL_DATA_PRODUCTION.${TEMP_DB}.${SRC_INPUT_TABLE}'
  )
  AND ctrl.source_status = 'A'
  AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
QUALIFY
  row_number() OVER (
    PARTITION BY ctrcode, src.c451_itemnr, src.c451_subitemnr
    ORDER BY IF(src.extraction_tmsp IS NULL, 0, 1), src.extraction_tmsp DESC
  ) = CAST('1' AS NUMERIC);