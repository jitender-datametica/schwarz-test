
-- EXTRACTION/FILTER LOGIC FOR EACH INDIVIDUAL WAWI HQ DB:


/* NO LINK TO INTERNATIONAL ITEM NUMBER */


/* INTERNATIONAL NUMBER NOT FOUND IN INTERNATIONAL KEYS */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id,
 prod_variant_nr, deleted_fg, record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt,
 dwh_mapping_tmsp, prod_key_type_cd, party_nat_key_nr, int_org_key_type_cd, prod_variant_nat_key_nr,
 local_prod_variant_nr, local_prod_variant_name, prod_nat_key_nr)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
      ART.ctrcode || '|' || CAST(ART.itemnr AS STRING) || '|' || CAST(ART.case_size AS STRING) AS prod_variant_nr,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'WAW_LOG' AS prod_variant_key_type_cd,
  'WAWI' AS source_system,
  CAST(ART.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(ART.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  'WAWI' AS prod_key_type_cd,
  ART.ctrcode AS party_nat_key_nr,
  'COUNTRY' AS party_key_type_cd,
      ART.ctrcode || '|' || CAST(ART.itemnr AS STRING) || '|' || CAST(ART.case_size AS STRING) AS
  prod_variant_nat_key_nr,
  CAST(ART.itemnr AS STRING) AS local_prod_variant_nr,
  COALESCE(ART.bez_lang, ART.deutschtext) AS local_prod_variant_name,
    ART.ctrcode || '|' || LTRIM(SUBSTR(CAST(ART.itemnr AS STRING), 1, 39), '0') AS prod_nat_key_nr
 FROM (SELECT ctrcode,
    ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(RIGHT(artikelnr, 4) AS BIGNUMERIC), 0) AS case_size,
    artikelnr,
    bez_lang,
    deutschtext,
    extraction_tmsp
   FROM ${temp_db}.t_wawi_precore_artikel) AS ART
  LEFT JOIN (SELECT DISTINCT ctrcode,
    ROUND(CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS int_itemnr
   FROM ${temp_db}.t_wawi_precore_t215_int_itemnr) AS II ON ART.ctrcode = II.ctrcode AND ART.itemnr = II.itemnr
  LEFT JOIN ldl_data_production_meta.t_product_key AS ipk ON CAST(II.int_itemnr AS STRING) = ipk.prod_nat_key_nr AND ipk
     .prod_key_type_cd IN ('CBX', 'FV') AND ipk.dwh_valid_fg
  LEFT JOIN (SELECT DISTINCT itemno
   FROM ldl_data_production_etl.t_wawi_precore_eks_item_wawi_item) AS EKS ON II.int_itemnr = EKS.itemno
 WHERE II.itemnr IS NULL
  OR ipk.prod_sid IS NULL AND EKS.itemno IS NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY ART.ctrcode, CAST(ART.itemnr AS STRING) ORDER BY ART.case_size IS NULL, ART.case_size
       )) = 1);