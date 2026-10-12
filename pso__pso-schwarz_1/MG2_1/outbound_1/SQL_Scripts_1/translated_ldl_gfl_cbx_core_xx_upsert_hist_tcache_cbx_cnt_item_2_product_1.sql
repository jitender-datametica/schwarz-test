INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(prod_type_cd, goods_on_consignment_fg, dwh_node_cd, prod_descr, tf_error_fg, dwh_load_id, prod_name, prod_creation_dt,
 item_type_cd, country_specific_prod_fg, source_system, extraction_dt, prod_nr, excl_from_vat_calc_fg, deleted_fg,
 record_id, packing_type_cd, dwh_mapping_tmsp, filename, prod_key_type_cd)
(SELECT prod_type_cd,
   goods_on_consignment_fg <> 0 AS goods_on_consignment_fg,
  dwh_node_cd,
  prod_descr,
  tf_error_fg,
  dwh_load_id,
  prod_name,
  prod_creation_dt,
  /* BRAND_NAME, */
  item_type_cd,
   country_specific_prod_fg <> 0 AS country_specific_prod_fg,
  -- FRAMEWORK AND TECHNICAL COLUMNS
  source_system,
  extraction_dt,
  prod_nr,
   excl_from_vat_calc_fg <> 0 AS excl_from_vat_calc_fg,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  packing_type_cd,
  CAST(dwh_mapping_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  filename,
  prod_key_type_cd
 FROM (SELECT DISTINCT 'CBX' AS prod_key_type_cd,
     'ITEM_1' AS prod_type_cd,
     'NON FOOD' AS item_type_cd,
     item_no AS prod_nr,
     SUBSTR(short_desc, 1, 100) AS prod_name,
     SUBSTR(item_desc, 1, 250) AS prod_descr,
     DATE(MAX(updated_on)) AS prod_creation_dt,
	 /* src.ldl_brand as BRAND_NAME, */
     ldl_packing_type AS packing_type_cd,
     0 AS goods_on_consignment_fg, -- FALSE
     
 0 AS excl_from_vat_calc_fg, -- FALSE
      CASE
      WHEN FALSE
      THEN 1
      ELSE 0
	 --,case when ldl_lot_no = 9999 then TRUE else FALSE end country_specific_prod_fg 
      END AS country_specific_prod_fg,
     'CBX' AS source_system,
     CURRENT_DATE AS extraction_dt,
     MAX(updated_on) AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'CBX' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.t_${src_input_table} -- LDL_DATA_PRODUCTION.${TEMP_DB}.t_${SRC_INPUT_TABLE} SRC
    WHERE item_no <> '0'
    GROUP BY item_no,
     short_desc,
     item_desc,
     ldl_packing_type,
     country_specific_prod_fg,
     ldl_brand
	 -- qualify ROW_NUMBER() OVER (PARTITION BY item_no, short_desc, item_desc, PROD_CREATION_DT ORDER BY updated_on desc) = 1
    UNION ALL
    SELECT DISTINCT 'CBX_CANCELED' AS prod_key_type_cd,
     'ITEM_1' AS prod_type_cd,
     'NON FOOD' AS item_type_cd,
     ref_no AS prod_nr,
     SUBSTR(short_desc, 1, 100) AS prod_name,
     SUBSTR(item_desc, 1, 250) AS prod_descr,
     DATE(updated_on) AS prod_creation_dt,
     /* src.ldl_brand as BRAND_NAME, */ ldl_packing_type AS packing_type_cd,
     0 AS goods_on_consignment_fg,
     -- FALSE
 0 AS excl_from_vat_calc_fg,
      CASE
      WHEN ldl_lot_no = 9999
      THEN 1 -- TRUE

      ELSE 0 -- FALSE

      END AS country_specific_prod_fg,
     'CBX' AS source_system,
     CURRENT_DATE AS extraction_dt,
     updated_on AS dwh_mapping_tmsp,
     0 AS tf_error_fg,
     0 AS deleted_fg,
     0 AS record_id,
     't_${SRC_INPUT_TABLE}' AS filename,
     'CBX' AS dwh_node_cd,
     '${LOAD_ID}' AS dwh_load_id
    FROM ${temp_db}.t_${src_input_table} AS src
    WHERE item_no = '0'
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY item_no, short_desc, item_desc, prod_creation_dt ORDER BY updated_on
          IS NULL DESC, updated_on DESC)) = 1) AS t9);