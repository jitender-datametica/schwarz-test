INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd
 , tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 prod_variant_sid, prod_variant_nat_key_nr, prod_variant_key_type_cd)
 /* EKS LOG */
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'EKS' AS source_system,
  CAST(SRC.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  vkey.prod_variant_sid,
  UPPER(SRC.ctrcode || '|' || CAST(SRC.wawi_itemnr AS STRING)) AS prod_variant_nat_key_nr,
  'LOG' AS prod_variant_key_type_cd
 FROM (SELECT art.ctrcode,
    ROUND(SAFE_CAST(art.artnrvier AS BIGNUMERIC), 0) AS wawi_itemnr,
    ROUND(SAFE_CAST(RIGHT(art.artikelnr, 4) AS BIGNUMERIC), 0) AS wawi_casesize,
    SK.itemno_sk,
    eksw.prod_num,
    COALESCE(SK.itemno_sk, eksw.prod_num) AS pvar_nat_key,
     CASE
     WHEN SK.itemno_sk IS NOT NULL
     THEN 'EKS_LOG'
     ELSE 'EKS_LOG_UNK'
     END AS pvar_key_type_cd,
    art.extraction_tmsp
   FROM ldl_data_production_etl.t_wawi_precore_artikel_1 AS art_1
    INNER JOIN ldl_data_production_etl.t_wawi_precore_eks_item_wawi_item_1 AS eksw ON art.ctrcode = eksw.ctrcode AND eksw
      .itemno_wawi = ROUND(SAFE_CAST(art.artnrvier AS BIGNUMERIC), 0)
    LEFT JOIN (SELECT DISTINCT itemno_sk
     FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy_1) AS SK ON eksw.itemno = SK.itemno_sk
    LEFT JOIN ldl_data_production_etl.t_wawi_precore_t026_wawi_item_1 AS wi ON SK.itemno_sk = wi.itemno
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY art.ctrcode, CAST(ROUND(ROUND(SAFE_CAST(art.artnrvier AS BIGNUMERIC), 0), 0) AS STRING)
         ORDER BY wi.seqid IS NULL, wi.seqid, SK.itemno_sk IS NULL, SK.itemno_sk)) = 1) AS SRC
  INNER JOIN ldl_data_production_meta.t_product_variant_key_1 AS vkey 
  /* !!!WITHOUT NEGATIVE-KEY-CAPTURE!!!
                                              KEY MUST ALREADY EXIST AFTER THE T_PRODUCT_VARIANT_1 (FV_SLS_UNK) JOB. */
											  ON vkey.prod_variant_nat_key_nr = CAST(SRC.pvar_nat_key AS STRING)
      AND vkey.dwh_valid_fg AND SRC.pvar_key_type_cd = vkey.prod_variant_key_type_cd);