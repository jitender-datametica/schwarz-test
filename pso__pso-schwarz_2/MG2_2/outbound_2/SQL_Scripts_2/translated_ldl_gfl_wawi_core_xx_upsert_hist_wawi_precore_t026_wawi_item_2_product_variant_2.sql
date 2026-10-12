
--      country_of_origin_sid,


--      null as  country_of_origin_sid,


-- null as  country_of_origin_sid,


-- null as  country_of_origin_sid,


/*sk*/


-- null as  country_of_origin_sid,


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (sales_variant_type_cd, dwh_node_cd, kind_name,
 tf_error_fg, weight_based_fg, sales_variant_content_meas, unit_cnt, unit_content_meas, dwh_load_id, case_size_cnt,
 prod_variant_nr, min_caliber_meas, prod_variant_name, logistic_variant_type_cd, fruits_and_vegetables_class_cd,
 deleted_fg, record_id, filename, caliber_uom_cd, max_caliber_meas, prod_variant_key_type_cd, non_food_variant_type_cd,
 gtin, content_uom_cd, extraction_dt, prod_nr, style_name, size_name, dwh_mapping_tmsp, prod_variant_type_cd,
 prod_key_type_cd)
(SELECT sales_variant_type_cd,
  dwh_node_cd,
  CAST(kind_name AS STRING) AS kind_name,
  tf_error_fg,
  CAST(weight_based_fg AS BOOL) AS weight_based_fg,
  sales_variant_content_meas,
  unit_cnt,
  unit_content_meas,
  dwh_load_id,
  case_size_cnt,
  CAST(prod_variant_nr AS STRING) AS prod_variant_nr,
  min_caliber_meas,
  prod_variant_name,
  logistic_variant_type_cd,
  CAST(fruits_and_vegetables_class_cd AS STRING) AS fruits_and_vegetables_class_cd,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  filename,
  CAST(caliber_uom_cd AS STRING) AS caliber_uom_cd,
  max_caliber_meas,
  'EKS_SLS',
  CAST(non_food_variant_type_cd AS STRING) AS non_food_variant_type_cd,
  CAST(gtin AS STRING) AS gtin,
  CAST(content_uom_cd AS STRING) AS content_uom_cd,
  CAST(extraction_dt AS DATE) AS extraction_dt,
  CAST(product_nr AS STRING) AS product_nr,
  CAST(style_name AS STRING) AS style_name,
  CAST(size_name AS STRING) AS size_name,
  CAST(dwh_mapping_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  prod_variant_type_cd,
  'EKS'
 FROM (SELECT h.itemno_ea AS prod_variant_nr,
     'EKS_SLS',
     h.itemno_ba AS product_nr,
     'EKS',
     src.itemdesc AS prod_variant_name,
     'SALES_2' AS prod_variant_type_cd,
     NULL AS weight_based_fg,
     CAST(NULL AS STRING) AS logistic_variant_type_cd,
     CAST(NULL AS NUMERIC) AS case_size_cnt,
     t3.ean_2 AS gtin,
     'FOOD' AS sales_variant_type_cd,
      src.bundlefact * src.volume AS sales_variant_content_meas,
     src.bundlefact AS unit_cnt,
     src.volume AS unit_content_meas,
     NULL AS content_uom_cd,
     NULL AS non_food_variant_type_cd,
     NULL AS size_name,
     NULL AS style_name,
     NULL AS kind_name,
     NULL AS fruits_and_vegetables_class_cd,
     NULL AS min_caliber_meas,
     NULL AS max_caliber_meas,
     NULL AS caliber_uom_cd,
     src.extraction_tmsp AS extraction_dt,
     src.extraction_tmsp AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'WAWI_HQ' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM (SELECT DISTINCT itemno_ea,
       itemno_ba
      FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy_2) AS h
     INNER JOIN ldl_data_production_etl.t_wawi_precore_t026_wawi_item_2 AS src ON h.itemno_ea = src.itemno
     LEFT JOIN (SELECT itemno,
       ean_2
      FROM ldl_data_production_etl.t_wawi_precore_t029_wawi_item_ean_2
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY itemno ORDER BY ean_2 IS NULL, ean_2)) = 1) AS t3 ON h.itemno_ea = t3.itemno
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY h.itemno_ea ORDER BY h.itemno_ba IS NULL, h.itemno_ba)) = 1
    UNION ALL
    SELECT src.itemno AS prod_variant_nr,
     'EKS_SLS_UNK',
     src.itemno AS product_nr,
     'EKS',
     src.itemdesc AS prod_variant_name,
     'SALES_2' AS prod_variant_type_cd,
     NULL AS weight_based_fg,
     CAST(NULL AS STRING) AS logistic_variant_type_cd,
     CAST(NULL AS NUMERIC) AS case_size_cnt,
     CAST(NULL AS INTEGER) AS gtin,
     'FOOD' AS sales_variant_type_cd,
     CAST(NULL AS NUMERIC) AS sales_variant_content_meas,
     CAST(NULL AS INTEGER) AS unit_cnt,
     CAST(NULL AS NUMERIC) AS unit_content_meas,
     NULL AS content_uom_cd,
     NULL AS non_food_variant_type_cd,
     NULL AS size_name,
     NULL AS style_name,
     NULL AS kind_name,
     NULL AS fruits_and_vegetables_class_cd,
     NULL AS min_caliber_meas,
     NULL AS max_caliber_meas,
     NULL AS caliber_uom_cd,
     src.extraction_tmsp AS extraction_dt,
     src.extraction_tmsp AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'WAWI_HQ' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM (SELECT DISTINCT itemno_ba
      FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy_2
      WHERE itemno_ba <> itemno_ea) AS h
     INNER JOIN ldl_data_production_etl.t_wawi_precore_t026_wawi_item_2 AS src ON h.itemno_ba = src.itemno
    UNION ALL
    SELECT sk.itemno_sk AS prod_variant_nr,
     'EKS_LOG',
     sk.itemno_ba AS product_nr,
     'EKS',
     src.itemdesc AS prod_variant_name,
     'LOGISTIC' AS prod_variant_type_cd,
     NULL AS weight_based_fg,
     sk.logistic_variant_type_cd,
     COALESCE(mqty.quantity, src.casesize, 1) AS case_size_cnt,
     CAST(NULL AS INTEGER) AS gtin,
     'FOOD' AS sales_variant_type_cd,
     CAST(NULL AS NUMERIC) AS sales_variant_content_meas,
     CAST(NULL AS INTEGER) AS unit_cnt,
     CAST(NULL AS NUMERIC) AS unit_content_meas,
     NULL AS content_uom_cd,
     NULL AS non_food_variant_type_cd,
     NULL AS size_name,
     NULL AS style_name,
     NULL AS kind_name,
     NULL AS fruits_and_vegetables_class_cd,
     NULL AS min_caliber_meas,
     NULL AS max_caliber_meas,
     NULL AS caliber_uom_cd,
     src.extraction_tmsp AS extraction_dt,
     src.extraction_tmsp AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'WAWI_HQ' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM (SELECT itemno_sk,
        CASE
        WHEN SUM(CASE
           WHEN itemno_sk = itemno_ea
           THEN 1
           ELSE 0
           END) >= 1
        THEN 'SINGLE'
        ELSE 'MIXED'
        END AS logistic_variant_type_cd,
       MAX(itemno_ba) AS itemno_ba
      FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy_2
      GROUP BY itemno_sk) AS sk
     INNER JOIN ldl_data_production_etl.t_wawi_precore_t026_wawi_item_2 AS src ON sk.itemno_sk = src.itemno
     LEFT JOIN (SELECT itemno_head,
       SUM(quantity) AS quantity
      FROM ldl_data_production_etl.t_wawi_precore_t024_wawi_item_dep_2
      WHERE level_head = 2
      GROUP BY itemno_head) AS mqty ON sk.itemno_sk = mqty.itemno_head
    UNION ALL
    SELECT itm.itemno AS prod_variant_nr,
     'EKS_LOG_UNK',
     itm.itemno AS product_nr,
     'EKS',
     itm.itemdesc AS prod_variant_name,
     'LOGISTIC' AS prod_variant_type_cd,
     NULL AS weight_based_fg,
     'SINGLE' AS logistic_variant_type_cd,
     1 AS case_size_cnt,
     CAST(NULL AS INTEGER) AS gtin,
     'FOOD' AS sales_variant_type_cd,
     CAST(NULL AS NUMERIC) AS sales_variant_content_meas,
     CAST(NULL AS INTEGER) AS unit_cnt,
     CAST(NULL AS NUMERIC) AS unit_content_meas,
     NULL AS content_uom_cd,
     NULL AS non_food_variant_type_cd,
     NULL AS size_name,
     NULL AS style_name,
     NULL AS kind_name,
     NULL AS fruits_and_vegetables_class_cd,
     NULL AS min_caliber_meas,
     NULL AS max_caliber_meas,
     NULL AS caliber_uom_cd,
     itm.extraction_tmsp AS extraction_dt,
     itm.extraction_tmsp AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     '${t_SRC_INPUT_TABLE}' AS filename,
     'WAWI_HQ' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM (SELECT DISTINCT itemno_ba
      FROM ldl_data_production_etl.t_wawi_precore_eks_hierarchy_2
      WHERE itemno_ba <> itemno_ea) AS nr
     INNER JOIN ldl_data_production_etl.t_wawi_precore_t026_wawi_item_2 AS itm ON nr.itemno_ba = itm.itemno) AS t23);