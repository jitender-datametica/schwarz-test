
/* WAW LOG */


/* NO LINK TO INTERNATIONAL ITEM_1 NUMBER */


/* INTERNATIONAL NUMBER NOT FOUND IN INTERNATIONAL KEYS */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt, dwh_mapping_tmsp, prod_variant_sid,
 prod_variant_nat_key_nr)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'LOG' AS prod_variant_nat_key_nr,
  'WAWI' AS source_system,
  CAST(CURRENT_TIMESTAMP() AS DATE) AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  ky.prod_variant_sid,
    UPPER(LEFT(ART.wawi_instanz_kzl, 2)) || '|' || CAST(ART.itemnr AS STRING)
 FROM (SELECT extraction_tmsp,
    gueltig_ab,
    artikelnr,
    wawi_instanz_kzl,
    inhalt_karton,
    delete_fg,
    artnrvier,
    bez_lang,
    deutschtext,
    packung,
    artgrupnr,
    unit_id,
    ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(RIGHT(artikelnr, 4) AS BIGNUMERIC), 0) AS case_size
   FROM hqwawiadm.artikel_1 AS ar
   WHERE delete_fg IS NULL) AS ART_1
  LEFT JOIN (SELECT DISTINCT wawi_instanz_kzl,
    ROUND(CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS c215_int_itemnr
   FROM hqwawiadm.t215_int_itemnr_1 AS itm
   WHERE delete_fg IS NULL) AS II ON ART.wawi_instanz_kzl = II.wawi_instanz_kzl AND ART.itemnr = II.itemnr
  LEFT JOIN ldl_data_production_meta.t_product_key_1 AS ipk ON CAST(II.c215_int_itemnr AS STRING) = ipk.prod_nat_key_nr
    AND ipk.prod_key_type_cd IN ('CBX', 'FV') AND ipk.dwh_valid_fg
  LEFT JOIN (SELECT DISTINCT itemno
   FROM ldl_data_production_etl.t_tcache_eks_item_wawi_item_1) AS EKS ON II.c215_int_itemnr = EKS.itemno
  INNER JOIN ldl_data_production_meta.t_product_variant_key_1 AS ky ON ky.prod_variant_key_type_cd = 'WAW_LOG' AND ky.prod_variant_nat_key_nr
      = UPPER(LEFT(ART.wawi_instanz_kzl, 2) || '|' || CAST(ART.itemnr AS STRING)) AND ky.dwh_valid_fg
 WHERE II.itemnr IS NULL
  OR ipk.prod_sid IS NULL AND EKS.itemno IS NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY ART.wawi_instanz_kzl, CAST(ART.itemnr AS STRING) ORDER BY ART.case_size
       IS NULL, ART.case_size)) = 1);