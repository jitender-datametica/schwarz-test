
/* EKS LOG */


/* !!!WITHOUT NEGATIVE-KEY-CAPTURE!!!
                                              KEY MUST ALREADY EXIST AFTER THE T_PRODUCT_VARIANT_2 (FV_SLS_UNK) JOB. */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt, dwh_mapping_tmsp, prod_variant_sid,
 prod_variant_nat_key_nr)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'LOG' AS prod_variant_key_type_cd,
  'EKS' AS source_system,
  CAST(SRC.extraction_tmsp AS DATE) AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  vkey.prod_variant_sid,
  UPPER(LEFT(SRC.wawi_instanz_kzl, 2) || '|' || CAST(SRC.wawi_itemnr AS STRING)) AS prod_variant_nat_key_nr
 FROM (SELECT art.wawi_instanz_kzl,
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
   FROM hqwawiadm.artikel_2 AS art_2
    INNER JOIN ldl_data_production_etl.t_tcache_eks_item_wawi_item_2 AS eksw ON art.wawi_instanz_kzl = eksw.wawi_instanz_kzl
       AND eksw.itemno_wawi = ROUND(SAFE_CAST(art.artnrvier AS BIGNUMERIC), 0)
    LEFT JOIN (SELECT DISTINCT itemno_sk
     FROM ldl_data_production_etl.t_tcache_eks_hierarchy_2) AS SK ON eksw.itemno = SK.itemno_sk
    LEFT JOIN (t026 AS (SELECT *
      FROM hqwawiadm.t026_wawi_item_2
      WHERE delete_fg IS NULL
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY seqid IS NULL DESC, seqid DESC)) = 1)) AS WI ON SK.itemno_sk
      = WI.itemno
   WHERE art.delete_fg IS NULL
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(art.wawi_instanz_kzl, 2), CAST(wawi_itemnr AS STRING) ORDER BY WI.seqid
         IS NULL, WI.seqid, SK.itemno_sk IS NULL, SK.itemno_sk)) = 1) AS SRC
  INNER JOIN ldl_data_production_meta.t_product_variant_key_2 AS vkey ON vkey.prod_variant_nat_key_nr = CAST(SRC.pvar_nat_key AS STRING)
      AND vkey.dwh_valid_fg AND SRC.pvar_key_type_cd = vkey.prod_variant_key_type_cd);