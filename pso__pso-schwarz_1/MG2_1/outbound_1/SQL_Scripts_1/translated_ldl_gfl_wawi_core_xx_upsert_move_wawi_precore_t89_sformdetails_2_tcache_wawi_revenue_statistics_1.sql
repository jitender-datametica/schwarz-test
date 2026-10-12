TRUNCATE TABLE   ${target_db}.${tgt_target_table};

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  store_key_type_cd,
  store_nk,
  country_org_key_type_cd,
  country_org_nk,
  real_estate_key_type_cd,
  real_estate_nk,
  stat_dt,
  bus_dt,
  curr_stat_fg,
  correction_seq,
  receipt_nr,
  receipt_line_nr,
  stat_src_cd,
  revenue_stat_type_id,
  receipt_cnt,
  turnover_net_val,
  turnover_gross_val,
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
  'STORE' AS store_type_key_cd,
  CONCAT(left(src.ctrcode, 2), '|', src.c89_storeno) AS store_nk,
  'COUNTRY_1' AS country_org_key_type_cd,
  left(src.ctrcode, 2) AS country_org_nk,
  'RE_1' AS real_estate_key_type_cd,
  CONCAT(left(src.ctrcode, 2), '|', src.c89_storeno) AS real_estate_nk,
  CAST(coalesce(src.c89_tgdate, src.c89_moddate) AS DATE) AS stat_dt,
  src.c89_formdate AS bus_dt,
  TRUE AS curr_state_fg,
  src.c89_correct_flag AS correction_seq,
  src.c89_formcount AS receipt_nr,
  src.c89_row AS reciept_line_nr,
  'WAWI' AS stat_src_cd,
  CASE src.c89_formtype
    WHEN CAST('136' AS NUMERIC)
    THEN 1
    WHEN CAST('146' AS NUMERIC)
    THEN 2
  END AS revenue_stat_type_id,
  src.c89_actpricegroup AS receipt_cnt, /* Correction */
  NULL AS turnover_net_val,
  src.c89_value AS turonover_gross_val,
  'WAWI_WH' AS source_system,
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${SRC_INPUT_TABLE}' AS filename,
  'WAWI_WH' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ${temp_db}.t_${src_input_table} AS src
WHERE
  src.c89_formtype IN (CAST('136' AS NUMERIC), CAST('146' AS NUMERIC));

/* QUALIFY ROW_NUMBER() OVER 
(PARTITION BY 
    LEFT( SRC.CTRCODE, 2), 
    C89_STORENO,
    C89_FORMDATE,
    C89_FORMTYPE,
    C89_CORRECT_FLAG
ORDER BY SRC.EXTRACTION_TMSP DESC
) = 1
*/;