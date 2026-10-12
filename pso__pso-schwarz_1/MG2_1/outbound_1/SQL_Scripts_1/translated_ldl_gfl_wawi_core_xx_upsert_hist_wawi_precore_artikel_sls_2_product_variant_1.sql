
-- ON  art.ctrcode = itmo.ctrcode AND art.artikelnr = itmo.artikelnr


/* No link to international item_1 number */


/* International number not found in international keys */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (sales_variant_type_cd, dwh_node_cd, tf_error_fg,
 weight_based_fg, dwh_load_id, case_size_cnt, prod_variant_nr, prod_variant_name, logistic_variant_type_cd, deleted_fg,
 record_id, filename, prod_variant_key_type_cd, source_system, gtin, extraction_dt, dwh_mapping_tmsp,
 prod_variant_type_cd, prod_key_type_cd, prod_variant_nat_key_nr, prod_nat_key_nr)
(SELECT CASE
   WHEN t0.artgrupnr BETWEEN 10 AND 14
   THEN 'FV'
   WHEN t0.artgrupnr BETWEEN 20 AND 99
   THEN 'FOOD'
   WHEN t0.artgrupnr BETWEEN 100 AND 400
   THEN 'NON FOOD'
   ELSE 'OTHER'
   END AS sales_variant_type_cd,
  'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
   itmo.weight_based_fg <> 0 AS weight_based_fg,
  '${LOAD_ID}' AS dwh_load_id,
  NULL AS case_size_cnt,
    t0.ctrcode || '|' || CAST(t0.itemnr AS STRING) AS prod_variant_nr,
  t0.deutschtext AS prod_variant_name,
  CAST(NULL AS STRING) AS logistic_variant_type_cd,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAW_SLS' AS prod_variant_key_type_cd,
  'WAWI' AS source_system,
  CAST(NULL AS STRING) AS gtin,
  CAST(t0.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(t0.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  'SALES_1' AS prod_variant_type_cd,
  'WAWI' AS prod_key_type_cd,
    t0.ctrcode || '|' || CAST(t0.itemnr AS STRING) AS prod_variant_nat_key_nr,
    t0.ctrcode || '|' || LTRIM(t0.artnrvier, '0') AS prod_nat_key_nr
 FROM (SELECT ctrcode,
    artikelnr,
    artgrupnr,
    deutschtext,
    artnrvier,
    ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr,
    extraction_tmsp,
    packung,
    unit_id
   FROM ${temp_db}.t_wawi_precore_artikel_1
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY ctrcode, CAST(ROUND(ROUND(CAST(artnrvier AS BIGNUMERIC), 0), 0) AS STRING)
       ORDER BY artikelnr IS NULL, artikelnr)) = 1) AS t0
  LEFT JOIN (SELECT DISTINCT ctrcode,
    ROUND(CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS c215_int_itemnr
   FROM ${temp_db}.t_wawi_precore_t215_int_itemnr_1) AS ii ON t0.ctrcode = ii.ctrcode AND t0.itemnr = ii.itemnr
  LEFT JOIN ldl_data_production_meta.t_product_key_1 AS ipk ON CAST(ii.c215_int_itemnr AS STRING) = ipk.prod_nat_key_nr
    AND ipk.prod_key_type_cd IN ('CBX', 'FV') AND ipk.dwh_valid_fg
  LEFT JOIN (SELECT DISTINCT *
   FROM ${temp_db}.t_wawi_precore_eks_item_wawi_item_1) AS eks ON ii.c215_int_itemnr = eks.itemno
  LEFT JOIN ${temp_db}.t_wawi_precore_t271_packagetype_1 AS pt ON t0.ctrcode = pt.ctrcode AND t0.packung = pt.c271_packdescript
    
  LEFT JOIN (SELECT c664_item,
    ctrcode
   FROM ${temp_db}.t_wawi_precore_t664_brokerage_item_1
   WHERE c664_std_flag = 1
    AND c664_modset = 0) AS ign ON t0.itemnr = CAST(ign.c664_item AS FLOAT64) AND t0.ctrcode = ign.ctrcode
  INNER JOIN (SELECT ctrcode,
    ROUND(CAST(SUBSTR(artikelnr, 1, LENGTH(artikelnr) - 4) AS BIGNUMERIC), 0) AS artikelnr,
    MAX(CASE
      WHEN gewichtsartikel = 1
      THEN 1
      ELSE gewichtsartikel
      END) AS weight_based_fg
   FROM ${temp_db}.t_wawi_precore_artikelbestell_1
   GROUP BY ctrcode,
    artikelnr) AS itmo ON t0.ctrcode = itmo.ctrcode AND t0.itemnr = itmo.artikelnr
  INNER JOIN ${temp_db}.t_wawi_precore_t277_unitfactors_1 AS unit_1 ON t0.ctrcode = unit.ctrcode AND t0.unit_id = unit.c277_id
    
 WHERE ii.itemnr IS NULL
  OR ipk.prod_sid IS NULL AND eks.itemno IS NULL);