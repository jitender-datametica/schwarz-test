
-- framework and technical columns


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, prod_variant_key_type_cd, source_system, extraction_dt, dwh_mapping_tmsp, prod_variant_sid,
 prod_variant_nat_key_nr)
(SELECT 'WAWI_WH' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'SLS_GTIN',
  'EKS' AS source_system,
  CAST(t0.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(t0.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  t0.prod_variant_sid,
  UPPER(CAST(t0.itemno_wawi AS STRING) || '|' || CAST(t0.ean_1 AS STRING)) AS itemno_wawi_ean
 FROM (SELECT DISTINCT ke.prod_variant_sid,
    ean0.itemno,
    eksw.itemno_wawi,
    ean0.ean_1,
    ean0.extraction_tmsp
   FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy_1 AS eksh
    INNER JOIN ldl_data_production_etl.t_wawi_precore_t029_wawi_item_ean_1 AS ean0 ON eksh.itemno_ea = ean0.itemno
    INNER JOIN ldl_data_production_etl.t_wawi_precore_eks_item_wawi_item_1 AS eksw ON eksh.itemno_ba = eksw.prod_num
    INNER JOIN ldl_data_production_meta.t_product_variant_key_1 AS ke ON ke.prod_variant_key_type_cd = 'EKS_SLS' AND CAST(eksh.itemno_ea AS STRING)
       = ke.prod_variant_nat_key_nr AND CURRENT_TIMESTAMP() BETWEEN ke.dwh_valid_from_tmsp AND ke.dwh_valid_to_tmsp) AS
  t0);