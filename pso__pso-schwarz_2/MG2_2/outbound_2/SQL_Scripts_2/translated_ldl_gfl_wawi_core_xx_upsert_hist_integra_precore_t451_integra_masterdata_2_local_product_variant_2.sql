INSERT INTO
${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd,
 tf_error_fg, dwh_load_id, source_system, extraction_dt, prod_nr, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 prod_key_type_cd, int_org_key_type_cd, party_nat_key_nr,-- FRAMEWORK AND TECHNICAL COLUMNS
  prod_variant_nat_key_nr, prod_variant_key_type_cd,
 prod_nat_key_nr, local_prod_variant_nr, prod_variant_nr, local_prod_variant_name, ctrcode)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  -- FRAMEWORK AND TECHNICAL COLUMNS
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(itm.itemnr AS STRING) AS prod_nr,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(waw.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  'FV' AS prod_key_type_cd,
  'COUNTRY_2' AS int_org_key_type_cd,
  iit.ctrcode AS party_nat_key_nr,
    CAST(itm.itemnr AS STRING) || '|' || CAST(itm.subitemnr AS STRING) AS prod_variant_nat_key_nr,
  'FV_SLS' AS prod_variant_key_type_cd,
  CAST(itm.itemnr AS STRING) AS prod_nat_key_nr,
    CAST(itm.itemnr AS STRING) || '|' || CAST(itm.subitemnr AS STRING) AS local_prod_variant_nr,
    CAST(itm.itemnr AS STRING) || '|' || CAST(itm.subitemnr AS STRING) AS prod_variant_nr,
    COALESCE(waw.bez_lang, waw.deutschtext) || '|' || CAST(itm.subitemnr AS STRING) AS local_prod_variant_name,
  iit.ctrcode
 FROM (-- Extraction/Filter Logic:
 SELECT DISTINCT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr,
    CAST(c451_subitemnr AS BIGNUMERIC) AS subitemnr
   FROM ${temp_db}.t_${src_input_table}) AS itm
  INNER JOIN (SELECT DISTINCT ctrcode,
    ROUND(CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS int_itemnr
   FROM ldl_data_production_etl.t_wawi_precore_t215_int_itemnr_2) AS iit ON itm.itemnr = iit.int_itemnr
  LEFT JOIN (SELECT ctrcode,
    ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr,
    bez_lang,
    deutschtext,
    extraction_tmsp
   FROM ldl_data_production_etl.artikel_2
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY ctrcode, CAST(ROUND(ROUND(CAST(artnrvier AS BIGNUMERIC), 0), 0) AS STRING)
       ORDER BY artikelnr IS NULL, artikelnr)) = 1) AS waw ON iit.ctrcode = waw.ctrcode AND iit.int_itemnr = waw.itemnr
 );



 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, prod_nr, deleted_fg, record_id, dwh_mapping_tmsp,
 filename, prod_key_type_cd, int_org_key_type_cd, party_nat_key_nr,-- FRAMEWORK AND TECHNICAL COLUMNS
  prod_variant_nat_key_nr, prod_variant_key_type_cd,
 prod_nat_key_nr, local_prod_variant_nr, prod_variant_nr, local_prod_variant_name, ctrcode)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
  source_system,
  extraction_dt,
  prod_nr,
  deleted_fg,
  record_id,
  dwh_mapping_tmsp,
  filename,
  prod_key_type_cd,
  int_org_key_type_cd,
  party_nat_key_nr,
  prod_variant_nat_key_nr -- FRAMEWORK AND TECHNICAL COLUMNS
,
  'FV_LOG' AS prod_variant_key_type_cd,
  prod_nat_key_nr,
  local_prod_variant_nr,
  prod_variant_nr,
  local_prod_variant_name,
  ctrcode
 FROM ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
 WHERE prod_variant_key_type_cd = 'FV_SLS');



 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, prod_nr, deleted_fg, record_id, dwh_mapping_tmsp,
 filename, prod_key_type_cd, int_org_key_type_cd, party_nat_key_nr, -- FRAMEWORK AND TECHNICAL COLUMNS
 prod_variant_nat_key_nr, prod_variant_key_type_cd,
 prod_nat_key_nr, local_prod_variant_nr, prod_variant_nr, local_prod_variant_name, ctrcode)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
   -- FRAMEWORK AND TECHNICAL COLUMNS
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(itm.itemnr AS STRING) AS prod_nr,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CAST(waw.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  'FV' AS prod_key_type_cd,
  'COUNTRY_2' AS int_org_key_type_cd,
  iit.country_iso_cd AS party_nat_key_nr,
  CAST(itm.itemnr AS STRING) AS prod_variant_nat_key_nr,
  'FV_SLS_UNK' AS prod_variant_key_type_cd,
  CAST(itm.itemnr AS STRING) AS prod_nat_key_nr,
  CAST(itm.itemnr AS STRING) AS local_prod_variant_nr,
  CAST(itm.itemnr AS STRING) AS prod_variant_nr,
  COALESCE(waw.bez_lang, waw.deutschtext) AS local_prod_variant_name,
  iit.country_iso_cd AS ctrcode
 FROM (SELECT itemnr
    FROM (SELECT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr,
       c451_subitemnr
      FROM ${temp_db}.t_${src_input_table}
      GROUP BY itemnr,
       c451_subitemnr) AS t0
    GROUP BY itemnr
    HAVING COUNT(*) > 1
    UNION ALL
    SELECT itemno
    FROM ldl_data_production_etl.t_wawi_precore_t026_wawi_item_2
    WHERE CAST(itemgrshortdesc AS INTEGER) BETWEEN 10 AND 13
     AND itemno NOT IN (SELECT DISTINCT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr
       FROM ${temp_db}.t_${src_input_table})) AS itm
  INNER JOIN (SELECT DISTINCT ctrcode AS country_iso_cd,
    ROUND(CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS int_itemnr
   FROM ldl_data_production_etl.t_wawi_precore_t215_int_itemnr_2) AS iit ON itm.itemnr = iit.int_itemnr
  LEFT JOIN (SELECT ctrcode AS country_iso_cd,
    ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr,
    bez_lang,
    deutschtext,
    extraction_tmsp
   FROM ldl_data_production_etl.t_wawi_precore_artikel_2
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY ctrcode, CAST(ROUND(ROUND(CAST(artnrvier AS BIGNUMERIC), 0), 0) AS STRING)
       ORDER BY artikelnr IS NULL, artikelnr)) = 1) AS waw ON iit.country_iso_cd = waw.country_iso_cd AND iit.itemnr =
    waw.itemnr);



 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, prod_nr, deleted_fg, record_id, dwh_mapping_tmsp,
 filename, prod_key_type_cd, int_org_key_type_cd, party_nat_key_nr, -- FRAMEWORK AND TECHNICAL COLUMNS
 prod_variant_nat_key_nr, prod_variant_key_type_cd,
 prod_nat_key_nr, local_prod_variant_nr, prod_variant_nr, local_prod_variant_name, ctrcode)
(SELECT dwh_node_cd,
  tf_error_fg,
  dwh_load_id,
  source_system,
  extraction_dt,
  prod_nr,
  deleted_fg,
  record_id,
  dwh_mapping_tmsp,
  filename,
  prod_key_type_cd,
  int_org_key_type_cd,
  party_nat_key_nr,
  prod_variant_nat_key_nr -- FRAMEWORK AND TECHNICAL COLUMNS
,
  'FV_LOG_UNK' AS prod_variant_key_type_cd,
  prod_nat_key_nr,
  local_prod_variant_nr,
  prod_variant_nr,
  local_prod_variant_name,
  ctrcode
 FROM ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
 WHERE prod_variant_key_type_cd = 'FV_SLS_UNK');