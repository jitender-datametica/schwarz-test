
--NAT_KEY_TYPE


--NAT_KEY


--NAT_KEY_TYPE


--NAT_KEY


-- FRAMEWORK AND TECHNICAL COLUMNS


-- LEFT OUTER CROSS JOIN ETL.t_wawi_precore_t026_wawi_item_1 AS eks


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
  CAST(COALESCE(eks.extraction_tmsp, t4.extraction_tmsp) AS DATE) AS extraction_dt,
  CAST(itemnr.itemnr AS STRING) AS prod_nr,
  CAST(COALESCE(eks.extraction_tmsp, t4.extraction_tmsp) AS TIMESTAMP) AS dwh_mapping_tmsp,
  'FV' AS prod_key_type_cd,
  'IFG' AS prod_grp_type_cd,
  'IFG' AS prod_grp_key_type_cd,
    CAST(ROUND(CAST(COALESCE(CAST(eks.itemgrshortdesc AS BIGNUMERIC), fg.itemgrpnr) AS BIGNUMERIC), 0) AS STRING) || '|'
     || CAST(CAST(COALESCE(eks.itemgroupid, fg.family_code) AS BIGNUMERIC) AS STRING) AS prod_grp_nr
 FROM (SELECT ROUND(CAST(c451_itemnr AS BIGNUMERIC), 0) AS itemnr
    FROM ldl_data_production_etl.t_integra_precore_t451_integra_masterdata_1
    UNION DISTINCT
    SELECT itemno
    FROM ldl_data_production_etl.t_wawi_precore_t026_wawi_item_1
    WHERE CAST(itemgrshortdesc AS INTEGER) BETWEEN 10 AND 13) AS itemnr
  LEFT JOIN ${temp_db}.${t_src_input_table} AS eks ON itemnr.itemnr = eks.itemno
  LEFT JOIN (SELECT ctrcode,
    artnrvier,
    extraction_tmsp,
    listenknznr,
    inhalt_karton,
    gueltig_ab,
    artikelnr,
    ROUND(CAST(artikelnr AS BIGNUMERIC), 0) AS itemnr
   FROM ldl_data_production_etl.t_wawi_precore_artikel_1 AS a
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ROUND(ROUND(CAST(artikelnr AS BIGNUMERIC), 0), 0) AS STRING) ORDER BY
          CASE
          WHEN ctrcode = 'DE'
          THEN 1
          WHEN ctrcode NOT IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN ctrcode = 'GR'
          THEN 3
          WHEN ctrcode IN ('BG', 'CY')
          THEN 4
          ELSE NULL
          END IS NULL, CASE
          WHEN ctrcode = 'DE'
          THEN 1
          WHEN ctrcode NOT IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN ctrcode = 'GR'
          THEN 3
          WHEN ctrcode IN ('BG', 'CY')
          THEN 4
          ELSE NULL
          END, ctrcode IS NULL, ctrcode, artikelnr IS NULL, artikelnr)) = 1) AS t4 ON itemnr.itemnr = t4.itemnr
  LEFT JOIN ldl_data_production_etl.t_wawi_precore_t214_itemaddinfo_1 AS itma ON t4.ctrcode = itma.ctrcode AND t4.artikelnr
     = itma.itemnr
  LEFT JOIN ldl_data_production_etl.t_wawi_precore_t038_itemfamily_1 AS fg ON itma.ctrcode = fg.ctrcode AND itma.family_id
     = fg.family_id
 WHERE COALESCE(eks.itemgrshortdesc, fg.itemgrpnr) IS NOT NULL
AND COALESCE(eks.itemgroupid, fg.family_code) IS NOT NULL);