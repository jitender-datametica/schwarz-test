-- Extract the records in scope for processing
CREATE OR REPLACE TEMP TABLE etl.vt_${src2tgt_temp_table1}_${src_context_area}_process AS
WITH ranked AS (
  SELECT
      *,
      ROW_NUMBER() OVER (
        PARTITION BY
            context_country,
            orig_store_nr,
            pos_terminal_id,
            orig_receipt_nr,
            receipt_business_date,
            posnr,
            receiptline_timestamp_begin
        ORDER BY receipt_timestamp_end DESC
      ) AS rn
  FROM ldl_data_production_etl.t_${src_input_table}
  WHERE LOWER(context_country) IN (${src_country_list})
    AND receiptline_transactiontype_id IN
      ('101','102','120','121','122','123','141','142','170','172','180','182',
       '201','202','220','221','222','223','270','272','280','282')
)
SELECT * FROM ranked
WHERE rn = 1
;

-- Transform those records to the target table
INSERT INTO ldl_data_production_${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
    context_country,
    orig_item_nr,
    retail_event_line_seq,
    event_start_tmsp,
    event_end_tmsp,
    bus_dt,
    retail_event_end_tmsp,
    cash_register_type_cd,
    cash_register_usg_type_cd,
    cashier_nr,
    auth_by_nr,
    prod_retail_line_type_cd,
    retail_event_line_scenario_id,
    prod_variant_sidx,
    local_prod_nr,
    prod_variant_input_nr,
    prod_variant_input_nr_type_cd,
    displayed_prod_variant_name,
    weight_based_fg,
    prod_variant_cnt,
    prod_variant_qty,
    uom_cd,
    unit_price,
    base_gross_val,
    retail_line_gross_val,
    retail_line_net_val,
    retail_line_vat_val,
    tax_class_cd,
    tax_pct,
    turnover_relevant_fg,
    prod_entry_method_cd,
    price_entry_method_cd,
    return_txt,
    parent_line_seq,
    cancel_line_seq,
    retail_event_key_type_cd,
    store_key_type_cd,
    country_org_key_type_cd,
    real_estate_key_type_cd,
    cash_register_key_type_cd,
    cust_key_type_cd,
    geo_area_key_type_cd,
    prod_return_reason_key_type_cd,
    orig_sales_event_key_type_cd,
    lidlplus_customer_cd,
    orig_receipt_nr,
    orig_store_nr,
    original_dat_formdate,
    original_orig_store_nr,
    original_orig_receipt_nr,
    original_pos_terminal_id,
    receipt_business_date,
    return_reason_cd,
    pos_terminal_id,
    source_system,
    extraction_dt,
    dwh_mapping_tmsp,
    tf_error_fg,
    deleted_fg,
    record_id,
    filename,
    dwh_node_cd,
    dwh_load_id
)
SELECT
    src.context_country,
    src.orig_item_nr,
    src.posnr AS retail_event_line_seq,
    src.receiptline_timestamp_begin AS event_start_tmsp,
    src.receiptline_timestamp_end AS event_end_tmsp,
    src.receipt_business_date AS bus_dt,
    src.receipt_timestamp_end AS retail_event_end_tmsp,
    NULL AS cash_register_type_cd,
    NULL AS cash_register_usg_type_cd,
    '-1' AS cashier_nr,
    '-1' AS auth_by_nr,
    CASE
        WHEN src.parent_line_nr IS NULL THEN
            CASE
                WHEN SUBSTR(src.receiptline_transactiontype_id, 2, 1) = '2' THEN 'D'    /* Deposit Return Line */
                WHEN src.price_sum_retail >= 0 OR src.receiptline_transactiontype_id IN ('101','102') THEN 'S'      /* Product Sales Line */
                ELSE 'R'        /* Product Return Line */
            END
        ELSE
            CASE WHEN src.price_sum_retail >= 0 THEN 'SD'   /* Related Deposit Sales Line */
            ELSE 'RD' END   /* Related Deposit Return Line */
    END AS prod_retail_line_type_cd,
    src.receiptline_transactiontype_id AS retail_event_line_scenario_id,
    CASE
        WHEN pv1.prod_sid = pv2.prod_sid THEN pvk1.prod_variant_sid ELSE '-1'
    END AS prod_variant_sidx,
    src.orig_item_nr AS local_prod_nr,
    src.barcode AS prod_variant_input_nr,
    NULL AS prod_variant_input_nr_type_cd,
    COALESCE(src.item_desc, ' ') AS displayed_prod_variant_name,        -- STAGER CURRENTLY NOT POPULATING ITEM_DESC FOR DEPOSITS (DEFECT)
    CASE WHEN src.fg_weight = '1' THEN TRUE ELSE FALSE END AS weight_based_fg,
    CASE WHEN src.fg_weight <> '1' THEN src.qty_sold ELSE NULL END AS prod_variant_cnt,
    CASE WHEN src.fg_weight = '1' THEN src.qty_sold ELSE NULL END AS prod_variant_qty,
    CASE
        WHEN src.fg_weight = '1' THEN
            CASE WHEN src.context_country = 'US' THEN 'LB' ELSE 'KG' END
        ELSE NULL
    END AS uom_cd,
    COALESCE(
        src.price_retail,
        ABS(src.price_sum_retail / NULLIF(src.qty_sold, 0)),
        ABS(src.price_sum_retail)
    ) AS unit_price,
    COALESCE(src.val_retail_orig, 0) AS base_gross_val,
    ROUND(
        src.price_sum_retail + 
        (src.qty_sold * -1 * 
         CASE
             WHEN src.val_discount <> 0 AND src.context_country = 'GB' THEN 0
             ELSE COALESCE(ROUND(src.val_discount, 2), 0)
         END
        ), 2
    ) AS retail_line_gross_val,
    ROUND(
        src.price_sum_retail +
        (src.qty_sold * -1 * 
         CASE
             WHEN src.val_discount <> 0 AND src.context_country = 'GB' THEN 0
             ELSE COALESCE(ROUND(src.val_discount, 2), 0)
         END
        ), 2
    ) * 100 / COALESCE(NULLIF(src.pct_vat, 0) + 100, 100) AS retail_line_net_val,
    src.val_vat AS retail_line_vat_val,
    CASE
        WHEN SAFE_CAST(src.type_vat AS INT64) BETWEEN 1 AND 9
        THEN CODE_POINTS_TO_STRING([64 + SAFE_CAST(src.type_vat AS INT64)])
        ELSE '@'
    END AS tax_class_cd,        
    /* 1->'A', 2->'B', …, 9->'I' 
             other values -> '@' */
    src.pct_vat AS tax_pct,
    CASE
        WHEN src.receipt_transactiontype_id IN ('100', '150') AND src.voided_by_line_nr IS NULL THEN TRUE       /* Turnover */
        ELSE FALSE      /* Non-Turnover */  
    END AS turnover_relevant_fg,
    src.item_entry_method_cd,
    src.price_entry_method_cd,
    src.return_text,
    src.parent_line_nr,
    src.voided_by_line_nr AS cancel_line_seq,
    'RET' AS retail_event_key_type_cd,
    'STORE' AS store_key_type_cd,
    'COUNTRY' AS country_org_key_type_cd,
    'RE' AS real_estate_key_type_cd,
    'REG' AS cash_register_key_type_cd,
    'CUST' AS cust_key_type_cd,
    'CTRY' AS geo_area_key_type_cd,
    'R' AS prod_return_reason_key_type_cd,
    'RET' AS orig_sales_event_key_type_cd,
    src.lidlplus_customer_cd,
    src.orig_receipt_nr,
    src.orig_store_nr,
    src.original_dat_formdate,
    src.original_orig_store_nr,
    src.original_orig_receipt_nr,
    src.original_pos_terminal_id,
    src.receipt_business_date,
    src.return_reason_cd,
    src.pos_terminal_id,
    'EJR' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'EJR' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM ldl_data_production_etl.vt_${src2tgt_temp_table1}_${src_context_area}_process src
LEFT JOIN ldl_data_production_meta.t_product_variant_key pvk1       -- NKC is ON, but we dont want to generate missing keys, so we access the keyspace directly here instead os fwork-based key assignment
  ON pvk1.prod_variant_key_type_cd = 'SLS_GTIN'
 AND UPPER(CONCAT(CAST(SAFE_CAST(src.orig_item_nr AS INT64) AS STRING), '|', src.barcode)) = UPPER(pvk1.prod_variant_nat_key_nr)
 AND pvk1.dwh_valid_fg = TRUE
LEFT JOIN ldl_data_production_core_rel.t_product_variant pv1
  ON pvk1.prod_variant_sid = pv1.prod_variant_sid AND pv1.dwh_valid_fg = TRUE
LEFT JOIN ldl_data_production_meta.t_product_variant_key pvk2
  ON pvk2.prod_variant_key_type_cd = 'SLS_UNK'
 AND UPPER(CONCAT(src.context_country, '|', CAST(SAFE_CAST(src.orig_item_nr AS INT64) AS STRING))) = pvk2.prod_variant_nat_key_nr
 AND pvk2.dwh_valid_fg = TRUE
LEFT JOIN ldl_data_production_core_rel.t_product_variant pv2
  ON pvk2.prod_variant_sidendente = pv2.prod_variant_sid AND pv2.dwh_valid_fg = TRUE
;

-- Delete those records from source using the PK
DELETE FROM ldl_data_production_etl.t_${src_input_table} src
WHERE EXISTS (
  SELECT 1
  FROM etl.vt_${src2tgt_temp_table1}_${src_context_area}_process process
  WHERE
      src.context_country = process.context_country
  AND src.orig_store_nr = process.orig_store_nr
  AND src.pos_terminal_id = process.pos_terminal_id
  AND src.orig_receipt_nr = process.orig_receipt_nr
  AND src.receipt_business_date = process.receipt_business_date
  AND (src.posnr = process.posnr OR (src.posnr IS NULL AND process.posnr IS NULL))
  AND (src.parent_line_nr = process.parent_line_nr OR (src.parent_line_nr IS NULL AND process.parent_line_nr IS NULL))
  AND (src.receiptline_timestamp_begin = process.receiptline_timestamp_begin OR (src.receiptline_timestamp_begin IS NULL AND process.receiptline_timestamp_begin IS NULL))
);
