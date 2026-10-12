
/* FV LOG */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt, dwh_mapping_tmsp, prod_variant_sid,
 prod_variant_nat_key_nr)
(SELECT DISTINCT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'LOG' AS prod_variant_key_type_cd,
  'FV' AS source_system,
  CAST(CURRENT_TIMESTAMP() AS DATE) AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  vkey.prod_variant_sid,
  UPPER(t9.ctrcode || '|' || CAST(t9.wawi_itemnr AS STRING)) AS prod_variant_nat_key_nr
 FROM (SELECT WINT.ctrcode,
    WINT.wawi_itemnr,
    WINT.wawi_casesize,
     CASE
     WHEN ITM.cnt = 1
     THEN CAST(ITM.itemnr AS STRING) || '|' || CAST(ITM.subitemnr AS STRING)
     ELSE CAST(ITM.itemnr AS STRING)
     END AS pvar_nat_key,
     CASE
     WHEN ITM.cnt = 1
     THEN 'FV_LOG'
     ELSE 'FV_LOG_UNK'
     END AS pvar_key_type_cd
   FROM (SELECT itemnr,
       COUNT(*) AS cnt,
       MAX(c451_subitemnr) AS subitemnr
      FROM (SELECT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr,
         c451_subitemnr
        FROM ${temp_db}.t_integra_precore_t451_integra_masterdata_2
        GROUP BY itemnr,
         c451_subitemnr) AS t0
      GROUP BY itemnr
      UNION ALL
      SELECT itemno,
       0 AS cnt,
       0 AS subitemnr
      FROM ${temp_db}.t_wawi_precore_t026_wawi_item_2
      WHERE CAST(itemgrshortdesc AS INTEGER) BETWEEN 10 AND 13
       AND itemno NOT IN (SELECT DISTINCT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr
         FROM ${temp_db}.t451_integra_masterdata_2)) AS ITM
    INNER JOIN (SELECT ctrcode,
      ROUND(SAFE_CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS int_itemnr,
      ROUND(SAFE_CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS wawi_itemnr,
      ROUND(SAFE_CAST(RIGHT(c215_itemnr, 4) AS BIGNUMERIC), 0) AS wawi_casesize
     FROM ${temp_db}.t_wawi_precore_t215_int_itemnr_2) AS WINT ON ITM.itemnr = WINT.int_itemnr
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY WINT.ctrcode, CAST(WINT.wawi_itemnr AS STRING) ORDER BY WINT.wawi_casesize
         IS NULL, WINT.wawi_casesize)) = 1) AS t9
  INNER JOIN ldl_data_production_meta.t_product_variant_key_2 AS vkey ON vkey.prod_variant_nat_key_nr = CAST(t9.pvar_nat_key AS STRING)
      AND vkey.dwh_valid_fg AND t9.pvar_key_type_cd = vkey.prod_variant_key_type_cd);