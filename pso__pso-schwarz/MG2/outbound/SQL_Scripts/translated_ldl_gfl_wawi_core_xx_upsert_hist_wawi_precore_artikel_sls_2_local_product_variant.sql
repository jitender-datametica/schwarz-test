
/* No link to international item number */


/* International number not found in international keys */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 prod_variant_nr, deleted_fg, record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt,
 dwh_mapping_tmsp, prod_key_type_cd, party_nat_key_nr, int_org_key_type_cd, prod_variant_nat_key_nr, prod_nat_key_nr,
 local_prod_variant_nr, local_prod_variant_name)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
    art.ctrcode || '|' || CAST(art.itemnr AS STRING) AS prod_variant_nr,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAW_SLS' AS prod_variant_key_type_cd,
  'WAWI' AS source_system,
  CAST(art.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(art.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  'WAWI' AS prod_key_type_cd,
  art.ctrcode AS party_nat_key_nr,
  'COUNTRY' AS party_key_type_cd,
    art.ctrcode || '|' || CAST(art.itemnr AS STRING) AS prod_variant_nat_key_nr,
    art.ctrcode || '|' || LTRIM(SUBSTR(CAST(art.itemnr AS STRING), 1, 39), '0') AS prod_nat_key_nr,
  CAST(art.itemnr AS STRING) AS local_prod_variant_nr,
  COALESCE(art.bez_lang, art.deutschtext) AS local_prod_variant_name
 FROM (SELECT ctrcode,
    ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr,
    bez_lang,
    deutschtext,
    extraction_tmsp
   FROM ${temp_db}.t_wawi_precore_artikel
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY ctrcode, CAST(ROUND(ROUND(CAST(artnrvier AS BIGNUMERIC), 0), 0) AS STRING)
       ORDER BY artikelnr IS NULL, artikelnr)) = 1) AS art
  LEFT JOIN (SELECT DISTINCT ctrcode,
    ROUND(CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS int_itemnr
   FROM ${temp_db}.t_wawi_precore_t215_int_itemnr) AS ii ON art.ctrcode = ii.ctrcode AND art.itemnr = ii.itemnr
  LEFT JOIN ldl_data_production_meta.t_product_key AS ipk ON CAST(ii.int_itemnr AS STRING) = ipk.prod_nat_key_nr AND ipk
     .prod_key_type_cd IN ('CBX', 'FV') AND ipk.dwh_valid_fg
  LEFT JOIN (SELECT DISTINCT *
   FROM ${temp_db}.t_wawi_precore_eks_item_wawi_item) AS eks ON ii.int_itemnr = eks.itemno
 WHERE ii.itemnr IS NULL
  OR ipk.prod_sid IS NULL AND eks.itemno IS NULL);