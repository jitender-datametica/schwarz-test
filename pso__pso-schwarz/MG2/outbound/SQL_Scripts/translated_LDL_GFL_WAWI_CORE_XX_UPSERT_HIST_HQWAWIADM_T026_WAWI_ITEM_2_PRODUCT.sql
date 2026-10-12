
-- FRAMEWORK AND TECHNICAL COLUMNS


-- FALSE


-- FALSE


-- FALSE


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, prod_nr, dwh_mapping_tmsp, prod_key_type_cd, prod_type_cd,
 goods_on_consignment_fg, prod_descr, prod_name, prod_creation_dt, item_type_cd, country_specific_prod_fg,
 excl_from_vat_calc_fg, packing_type_cd)
(SELECT DISTINCT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${t_SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS source_system,
  CAST(wi.extraction_tmsp AS DATE) AS extraction_dt,
  CAST(wi.itemno AS STRING) AS prod_nr,
  CAST(wi.extraction_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  'EKS' AS prod_key_type_cd,
  'ITEM' AS prod_type_cd,
   0 <> 0 AS goods_on_consignment_fg,
  wi.itemdesc AS prod_descr,
  wi.itemdesc AS prod_name,
  DATE(MIN(wi.insertdate) OVER (PARTITION BY wi.itemno RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) AS
  prod_creation_dt,
  'FOOD' AS item_type_cd,
   0 <> 0 AS country_specific_prod_fg,
   0 <> 0 AS excl_from_vat_calc_fg,
  pt.c271_int_short AS packing_type_cd
 FROM (SELECT DISTINCT itemno_ba
   FROM ldl_data_production_etl.t_tcache_eks_hierarchy) AS ba
  INNER JOIN hqwawiadm.t026_wawi_item AS wi ON ba.itemno_ba = wi.itemno
  LEFT JOIN hqwawiadm.t271_packagetype AS pt ON wi.wawi_instanz_kzl = pt.wawi_instanz_kzl AND wi.packageid = pt.c271_packnr
      AND pt.delete_fg IS NULL
 WHERE wi.delete_fg IS NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY wi.itemno ORDER BY wi.seqid IS NULL DESC, wi.seqid DESC)) = 1);