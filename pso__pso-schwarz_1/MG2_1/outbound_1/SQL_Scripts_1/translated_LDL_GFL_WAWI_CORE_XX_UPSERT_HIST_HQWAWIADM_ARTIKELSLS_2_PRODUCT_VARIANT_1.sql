
-- ON  art.wawi_instanz_kzl = itmo.wawi_instanz_kzl AND art.artikelnr = itmo.artikelnr


/* No link to international item_1 number */


/* International number not found in international keys */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (sales_variant_type_cd, dwh_node_cd, tf_error_fg,
 weight_based_fg, dwh_load_id, case_size_cnt, prod_variant_nr, prod_variant_name, logistic_variant_type_cd, deleted_fg,
 record_id, filename, prod_variant_key_type_cd, source_system, gtin, extraction_dt, dwh_mapping_tmsp,
 prod_variant_type_cd, prod_key_type_cd, prod_nat_key_nr, prod_variant_nat_key_nr)
(SELECT CASE
   WHEN t1.artgrupnr BETWEEN 10 AND 14
   THEN 'FV'
   WHEN t1.artgrupnr BETWEEN 20 AND 99
   THEN 'FOOD'
   WHEN t1.artgrupnr BETWEEN 100 AND 400
   THEN 'NON FOOD'
   ELSE 'OTHER'
   END AS sales_variant_type_cd,
  'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
   itmo.weight_based_fg <> 0 AS weight_based_fg,
  '${LOAD_ID}' AS dwh_load_id,
  NULL AS case_size_cnt,
    LEFT(t1.wawi_instanz_kzl, 2) || '|' || CAST(t1.itemnr AS STRING) AS prod_variant_nr,
  t1.deutschtext AS prod_variant_name,
  CAST(NULL AS STRING) AS logistic_variant_type_cd,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAW_SLS' AS prod_variant_key_type_cd,
  'WAWI' AS source_system,
  CAST(NULL AS STRING) AS gtin,
  CAST(t1.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(t1.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  'SALES_1' AS prod_variant_type_cd,
  'WAWI' AS prod_key_type_cd,
    t1.wawi_instanz_kzl || '|' || LTRIM(t1.artnrvier, '0') AS prod_nat_key_nr,
    LEFT(t1.wawi_instanz_kzl, 2) || '|' || CAST(t1.itemnr AS STRING) AS prod_variant_nat_key_nr
 FROM (SELECT wawi_instanz_kzl,
    artikelnr,
    artgrupnr,
    deutschtext,
    artnrvier,
    ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr,
    extraction_tmsp,
    packung,
    unit_id
   FROM hqwawiadm.artikel_1
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
  LEFT JOIN hqwawiadm.t271_packagetype_1 AS pt ON t1.wawi_instanz_kzl = pt.wawi_instanz_kzl AND t1.packung = pt.c271_packdescript
      AND pt.delete_fg IS NULL
  LEFT JOIN (SELECT c664_item,
    wawi_instanz_kzl
   FROM hqwawiadm.t664_brokerage_item_1
   WHERE c664_std_flag = 1
    AND c664_modset = 0
    AND delete_fg IS NULL) AS ign ON t1.itemnr = CAST(ign.c664_item AS FLOAT64) AND t1.wawi_instanz_kzl = ign.wawi_instanz_kzl
    
  INNER JOIN (SELECT wawi_instanz_kzl,
    ROUND(CAST(SUBSTR(artikelnr, 1, LENGTH(artikelnr) - 4) AS BIGNUMERIC), 0) AS artikelnr,
    MAX(CASE
      WHEN gewichtsartikel = 1
      THEN 1
      ELSE gewichtsartikel
      END) AS weight_based_fg
   FROM hqwawiadm.artikelbestell_1
   WHERE delete_fg IS NULL
   GROUP BY wawi_instanz_kzl,
    artikelnr) AS itmo ON t1.wawi_instanz_kzl = itmo.wawi_instanz_kzl AND t1.itemnr = itmo.artikelnr
  INNER JOIN hqwawiadm.t277_unitfactors_1 AS unit_1 ON t1.wawi_instanz_kzl = unit.wawi_instanz_kzl AND t1.unit_id = unit.c277_id
      AND unit.delete_fg IS NULL
 WHERE ii.itemnr IS NULL
  OR ipk.prod_sid IS NULL AND eks.itemno IS NULL);