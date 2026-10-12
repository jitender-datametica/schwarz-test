
--NAT_KEY_TYPE


--NAT_KEY


--NAT_KEY_TYPE


--NAT_KEY    


-- FRAMEWORK AND TECHNICAL COLUMNS


-- FRAMEWORK AND TECHNICAL COLUMNS


/* No link to international item_2 number */


/* International number not found in international keys */


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, prod_nr, dwh_mapping_tmsp, prod_key_type_cd, prod_grp_type_cd,
 prod_grp_key_type_cd, prod_grp_nr)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS source_system,
  CAST(itma.extraction_tmsp AS DATE) AS extraction_dt,
    UPPER(t0.ctrcode) || '|' || CAST(t0.itemnr AS STRING) AS prod_nr,
  CAST(itma.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  'WAWI' AS prod_key_type_cd,
  'IFG' AS prod_grp_type_cd,
  'IFG' AS prod_grp_key_type_cd,
    CAST(fg.itemgrpnr AS STRING) || '|' || CAST(fg.family_code AS STRING) AS prod_grp_nr
 FROM (SELECT ctrcode,
    artnrvier,
    extraction_tmsp,
    listenknznr,
    inhalt_karton,
    gueltig_ab,
    artikelnr,
    ROUND(CAST(artnrvier AS BIGNUMERIC), 0) AS itemnr
   FROM ldl_data_production_etl.t_wawi_precore_artikel_2 AS a
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY ctrcode, CAST(ROUND(ROUND(CAST(artnrvier AS BIGNUMERIC), 0), 0) AS STRING)
       ORDER BY artikelnr IS NULL, artikelnr)) = 1) AS t0
  LEFT JOIN (SELECT DISTINCT ctrcode,
    ROUND(CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS BIGNUMERIC), 0) AS itemnr,
    ROUND(CAST(c215_int_itemnr AS BIGNUMERIC), 0) AS c215_int_itemnr
   FROM ldl_data_production_etl.t_wawi_precore_t215_int_itemnr_2) AS ii ON t0.ctrcode = ii.ctrcode AND t0.itemnr = ii.itemnr
    
  LEFT JOIN ldl_data_production_meta.t_product_key_2 AS ipk ON CAST(ii.c215_int_itemnr AS STRING) = ipk.prod_nat_key_nr
    AND ipk.prod_key_type_cd IN ('CBX', 'FV') AND ipk.dwh_valid_fg
  LEFT JOIN (SELECT DISTINCT itemno
   FROM ldl_data_production_etl.t_wawi_precore_eks_item_wawi_item_2) AS eks ON ii.c215_int_itemnr = eks.itemno
  INNER JOIN ldl_data_production_etl.t_wawi_precore_t214_itemaddinfo_2 AS itma ON t0.ctrcode = itma.ctrcode AND t0.artikelnr
     = itma.itemnr
  INNER JOIN ldl_data_production_etl.t_wawi_precore_t038_itemfamily_2 AS fg ON itma.ctrcode = fg.ctrcode AND itma.family_id
     = fg.family_id
 WHERE ii.itemnr IS NULL
  OR ipk.prod_sid IS NULL AND eks.itemno IS NULL);