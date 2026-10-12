
-- FRAMEWORK AND TECHNICAL COLUMNS


/* WAW SLS_UNK */


--inner join meta.t_product_variant_key_1 as ky


/* No link to international item_1 number */


/* International number not found in international keys */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt, dwh_mapping_tmsp, prod_variant_sid,
 prod_variant_nat_key_nr)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'SLS_UNK' AS prod_variant_key_type_cd,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  ky.prod_variant_sid,
  UPPER(LEFT(t1.wawi_instanz_kzl, 2) || '|' || CAST(t1.itemnr AS STRING)) AS prod_variant_nat_key_nr
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
    ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr
   FROM hqwawiadm.artikel_1 AS a
   WHERE delete_fg IS NULL
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY wawi_instanz_kzl, CAST(ROUND(ROUND(CAST(artnrvier AS BIGNUMERIC), 0), 0) AS
          STRING) ORDER BY artikelnr IS NULL, artikelnr)) = 1) AS t1_1
  LEFT JOIN (SELECT DISTINCT wawi_instanz_kzl,
    ROUND(CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS c215_int_itemnr
   FROM hqwawiadm.t215_int_itemnr_1
   WHERE delete_fg IS NULL) AS ii ON t1.wawi_instanz_kzl = ii.wawi_instanz_kzl AND t1.itemnr = ii.itemnr
  LEFT JOIN ldl_data_production_meta.t_product_key_1 AS ipk ON CAST(ii.c215_int_itemnr AS STRING) = ipk.prod_nat_key_nr
    AND ipk.prod_key_type_cd IN ('CBX', 'FV') AND ipk.dwh_valid_fg
  LEFT JOIN (SELECT DISTINCT itemno
   FROM ldl_data_production_etl.t_tcache_eks_item_wawi_item_1) AS eks ON ii.c215_int_itemnr = eks.itemno
  INNER JOIN ldl_data_production_meta.${t_src_input_table} AS ky ON ky.prod_variant_key_type_cd = 'WAW_SLS' AND ky.prod_variant_nat_key_nr
      = UPPER(LEFT(t1.wawi_instanz_kzl, 2) || '|' || CAST(t1.itemnr AS STRING)) AND ky.dwh_valid_fg
 WHERE ii.itemnr IS NULL
  OR ipk.prod_sid IS NULL AND eks.itemno IS NULL);