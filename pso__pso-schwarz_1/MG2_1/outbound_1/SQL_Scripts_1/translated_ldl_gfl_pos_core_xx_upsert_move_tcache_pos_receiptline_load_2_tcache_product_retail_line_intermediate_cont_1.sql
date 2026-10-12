
-- Extract the records in scope for processing


CREATE OR REPLACE TEMPORARY TABLE
vt_$_1{src2tgt_temp_table1}_${src_context_area}_process AS
SELECT *
FROM ldl_data_production_etl.t_${src_input_table} AS src
WHERE LOWER(context_country) IN (${src_country_list})
 AND receiptline_transactiontype_id IN ('101', '102', '120', '121', '122', '123', '141', '142', '170', '172', '180',
   '182', '201', '202', '220', '221', '222', '223', '270', '272', '280', '282')
QUALIFY (ROW_NUMBER() OVER (PARTITION BY context_country, CAST(orig_store_nr AS STRING), CAST(pos_terminal_id AS STRING)
      , CAST(orig_receipt_nr AS STRING), receipt_business_date, CAST(posnr AS STRING), receiptline_timestamp_begin
    ORDER BY receipt_timestamp_end IS NULL DESC, receipt_timestamp_end DESC)) = 1;


-- Transform those records to the target table
 INSERT INTO
${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd,
 tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 base_gross_val, original_orig_store_nr, country_org_key_type_cd, receipt_business_date, weight_based_fg,
 cancel_line_seq, prod_variant_input_nr_type_cd, unit_price, retail_line_net_val, prod_variant_sidx, store_key_type_cd,
 orig_store_nr, event_start_tmsp, parent_line_seq, context_country, prod_entry_method_cd, geo_area_key_type_cd,
 retail_event_line_scenario_id, event_end_tmsp, uom_cd, retail_line_vat_val, original_dat_formdate, prod_variant_qty,
 retail_event_end_tmsp, original_pos_terminal_id, tax_class_cd, bus_dt, cashier_nr, auth_by_nr, return_reason_cd,
 cash_register_key_type_cd, real_estate_key_type_cd, lidlplus_customer_cd, cash_register_natural_key,
 prod_retail_line_type_cd, orig_receipt_nr, prod_variant_input_nr, price_entry_method_cd, turnover_relevant_fg,
 cust_key_type_cd, displayed_prod_variant_name, retail_line_gross_val, pos_terminal_id, orig_sales_event_key_type_cd,
 return_txt, cash_register_type_cd, retail_event_line_seq, retail_event_key_type_cd, tax_pct, original_orig_receipt_nr,
 cash_register_usg_type_cd, prod_variant_cnt, prod_return_reason_key_type_cd)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  't_${SRC_INPUT_TABLE}' AS filename,
  COALESCE(val_retail_orig, 0) AS base_gross_val,
  original_orig_store_nr,
  'COUNTRY_1' AS country_org_key_type_cd,
  receipt_business_date,
   fg_weight = '1' AS weight_based_fg,
  voided_by_line_nr AS cancel_line_seq,
  CAST(NULL AS STRING) AS prod_variant_input_nr_type_cd,
  COALESCE(price_retail, ABS(price_sum_retail / IF(qty_sold = 0, NULL, qty_sold)), ABS(price_sum_retail)) AS unit_price
  ,
    ROUND(price_sum_retail + qty_sold * - 1 * CASE
        WHEN val_discount <> 0 AND context_country = 'GB'
        THEN 0
        ELSE COALESCE(ROUND(val_discount, 2), 0)
        END, 2) * 100 / COALESCE(IF(pct_vat = 0, NULL, pct_vat) + 100, 100) AS retail_line_net_val,
  '-1' AS prod_variant_sidx,
  'STORE' AS store_key_type_cd,
  orig_store_nr,
  CAST(receiptline_timestamp_begin AS TIMESTAMP) AS event_start_tmsp,
  parent_line_nr AS parent_line_seq,
  context_country,
  item_entry_method_cd AS prod_entry_method_cd,
  'CTRY' AS geo_area_key_type_cd,
  receiptline_transactiontype_id AS retail_event_line_scenario_id,
  CAST(receiptline_timestamp_end AS TIMESTAMP) AS event_end_tmsp,
   CASE
   WHEN fg_weight = '1'
   THEN CASE
    WHEN context_country = 'US'
    THEN 'LB'
    ELSE 'KG'
    END
   ELSE NULL
   END AS uom_cd,
  val_vat AS retail_line_vat_val,
  original_dat_formdate,
   CASE
   WHEN fg_weight = '1'
   THEN qty_sold
   ELSE NULL
   END AS prod_variant_qty,
  CAST(receipt_timestamp_end AS TIMESTAMP) AS retail_event_end_tmsp,
  original_pos_terminal_id,
   CASE
   WHEN ROUND(SAFE_CAST(type_vat AS BIGNUMERIC), 0) BETWEEN 1 AND 9
   THEN CHR(CAST(64 + CAST(type_vat AS FLOAT64) AS INTEGER))
   ELSE '@'
   END AS tax_class_cd,
   /* 1->'A', 2->'B', …, 9->'I' 
             other values -> '@' */ 
  dwh_mapping_dt AS bus_dt,
  '-1' AS cashier_nr,
  '-1' AS auth_by_nr,
  return_reason_cd,
  'DUMMY_1' AS cash_register_key_type_cd,
  'RE_1' AS real_estate_key_type_cd,
  lidlplus_customer_cd,
  'DUMMY_1|DUMMY_1' AS cash_register_natural_key,
   CASE
   WHEN parent_line_nr IS NULL
   THEN CASE
    WHEN SUBSTR(receiptline_transactiontype_id, 2, 1) = '2'
    THEN 'D' /* Deposit Return Line */
    WHEN price_sum_retail >= 0
    THEN 'S' /* Product Sales_1 Line */
    ELSE 'R' /* Product Return Line */
    END
   ELSE CASE
    WHEN price_sum_retail >= 0
    THEN 'SD' /* Related Deposit Sales_1 Line */
    ELSE 'RD' /* Related Deposit Return Line */
    END
   END AS prod_retail_line_type_cd,
  orig_receipt_nr,
  barcode AS prod_variant_input_nr,
  price_entry_method_cd,
  ((receipt_transactiontype_id IN ('100', '150') AND voided_by_line_nr IS NULL)) IS TRUE AS turnover_relevant_fg,
  'CUST' AS cust_key_type_cd,
  COALESCE(item_desc, ' ') AS displayed_prod_variant_name,
  -- STAGER CURRENTLY NOT POPULATING ITEM_DESC FOR DEPOSITS (DEFECT)
  ROUND(price_sum_retail + qty_sold * - 1 * CASE
      WHEN val_discount <> 0 AND context_country = 'GB'
      THEN 0 /* Turnover */
      ELSE COALESCE(ROUND(val_discount, 2), 0) /* Non-Turnover */ 
      END, 2) AS retail_line_gross_val,
  pos_terminal_id,
  'RET' AS orig_sales_event_key_type_cd,
  return_text AS return_txt,
  CAST(NULL AS STRING) AS cash_register_type_cd,
  posnr AS retail_event_line_seq,
  'RET' AS retail_event_key_type_cd,
  pct_vat AS tax_pct,
  original_orig_receipt_nr,
  CAST(NULL AS STRING) AS cash_register_usg_type_cd,
   CASE
   WHEN fg_weight <> '1'
   THEN qty_sold
   ELSE NULL
   END AS prod_variant_cnt,
  'R' AS prod_return_reason_key_type_cd
 FROM vt_$_1{src2tgt_temp_table1}_${src_context_area}_process AS src);


-- Delete those records from source using the PK


DELETE FROM ldl_data_production_etl.t_${src_input_table} AS src
WHERE EXISTS (SELECT 1
 FROM vt_$_1{src2tgt_temp_table1}_${src_context_area}_process AS process
 WHERE src.context_country = context_country
  AND src.orig_store_nr = orig_store_nr
  AND src.pos_terminal_id = pos_terminal_id
  AND src.orig_receipt_nr = orig_receipt_nr
  AND src.receipt_business_date = receipt_business_date
  AND src.posnr IS NOT DISTINCT FROM posnr
  AND src.parent_line_nr IS NOT DISTINCT FROM parent_line_nr
  AND src.receiptline_timestamp_begin IS NOT DISTINCT FROM receiptline_timestamp_begin);