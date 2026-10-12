DELETE FROM ldl_data_production_$_2{target_db}.${tgt_target_table}
WHERE TRUE;

-- Multi-Stage transform required for prod_variant_sid assignment, but also helps for discount_fg

CREATE OR REPLACE TABLE ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}_set_a AS
SELECT
        src.retail_event_sid AS retail_event_sid,
        src.posnr AS retail_event_line_seq,
        src.receiptline_timestamp_begin AS event_start_tmsp,
        src.receiptline_timestamp_end AS event_end_tmsp,
        src.receipt_business_date AS bus_dt,
        src.receipt_timestamp_end AS retail_event_end_tmsp,
        src.store_sid AS store_sid,
        src.country_org_sid AS country_org_sid,
        src.country_org_cd AS country_org_cd,
        src.real_estate_sid AS real_estate_sid,
        src.cash_register_sid AS cash_register_sid,
        src.pos_type AS cash_register_type_cd,
        NULL AS cash_register_usg_type_cd,
        checker_hash AS cashier_hash,
        receiptline_authority_hash AS auth_by_hash,
        src.cust_sid AS cust_sid,
        CASE WHEN parent_line_nr IS NULL
            THEN CASE WHEN SUBSTR(receiptline_transactiontype_id, 2, 1) = '2'
                      THEN 'D'  -- Deposit Return Line
                 WHEN SUBSTR(receiptline_transactiontype_id, 2, 1) = '0'
                      THEN 'S'  -- Product Sales_2 Line
                      ELSE 'R'  -- Product Return Line
                 END
            ELSE CASE WHEN SUBSTR(receiptline_transactiontype_id, 2, 1) = '0'
                      THEN 'SD' -- Related Deposit Sales_2 Line
                      ELSE 'RD' -- Related Deposit Return Line
                 END
        END AS prod_retail_line_type_cd,
        orig_item_nr AS local_prod_nr,
        src.receiptline_transactiontype_id AS retail_event_line_scenario_id,
        --COALESCE(PVK1.PROD_VARIANT_SID, '-1') as PROD_VARIANT_SID,
        CASE WHEN pv1.prod_sid = pv2.prod_sid
            THEN pvk1.prod_variant_sid
            ELSE '-1'
        END AS prod_variant_sid,
        src.barcode AS prod_variant_input_nr,
        NULL AS prod_variant_input_nr_type_cd,
        COALESCE(src.item_desc,' ') AS displayed_prod_variant_name, -- STAGER CURRENTLY NOT POPULATING ITEM_DESC FOR DEPOSITS (DEFECT)
        CASE WHEN src.fg_weight = '1' THEN TRUE ELSE FALSE END AS weight_based_fg,
        CASE WHEN src.fg_weight <> '1' THEN src.qty_sold ELSE NULL END AS prod_variant_cnt,
        CASE WHEN src.fg_weight = '1' THEN src.qty_sold ELSE NULL END AS prod_variant_qty,
        CASE WHEN src.fg_weight = '1'
             THEN CASE WHEN src.country_org_cd = 'US' THEN 'LB' ELSE 'KG' END
             ELSE NULL
        END AS uom_cd,
        COALESCE(
            src.price_retail,
            ABS(src.price_sum_retail / NULLIF(src.qty_sold, 0)),
            ABS(src.price_sum_retail)
        ) AS unit_price,
        COALESCE(src.val_retail_orig, 0) AS base_gross_val,
        ROUND(
            src.price_sum_retail
            + (src.qty_sold * -1 *
              (CASE WHEN src.val_discount <> 0 AND src.country_org_cd = 'GB'
                    THEN 0 ELSE COALESCE(ROUND(src.val_discount,2),0)
               END)
            ),
            2
        ) AS retail_line_gross_val,
        ROUND(
            src.price_sum_retail
            + (src.qty_sold * -1 *
              (CASE WHEN src.val_discount <> 0 AND src.country_org_cd = 'GB'
                    THEN 0 ELSE COALESCE(ROUND(src.val_discount,2),0)
               END)
            ),
            2
        ) * 100 / COALESCE(NULLIF(src.pct_vat,0)+100,100) AS retail_line_net_val,
        src.val_vat AS retail_line_vat_val,
        CASE WHEN SAFE_CAST(type_vat AS INT64) BETWEEN 1 AND 9
             THEN CHR(64 + SAFE_CAST(type_vat AS INT64)) ELSE '@'
        END AS tax_class_cd, -- 1->'A', …, 9->'I', other -> '@'
        'CTRY' AS geo_area_key_type_cd,
        src.pct_vat AS tax_pct,
        src.curr_cd AS curr_cd,
        CASE WHEN src.receipt_transactiontype_id IN ('100','150')
                  AND src.voided_by_line_nr IS NULL
             THEN TRUE       /* Turnover */
             ELSE FALSE     /* Non-Turnover */ 
        END AS turnover_relevant_fg,
        src.item_entry_method_cd AS prod_entry_method_cd,
        src.price_entry_method_cd AS price_entry_method_cd,
        'R' AS prod_return_reason_key_type_cd,
        src.return_text AS return_txt,
        (
            (((CAST(FORMAT_DATE('%Y%m%d', src.original_dat_formdate) AS INT64) * 100
               + ASCII(SUBSTR(src.context_country,1,1))) * 100
               + ASCII(SUBSTR(src.context_country,2,1))) * 100000000
             + CASE WHEN SAFE_CAST(src.original_orig_store_nr AS INT64) <= 99999999
                    THEN SAFE_CAST(src.original_orig_store_nr AS INT64) ELSE 0 END
            ) * 10000
            + CASE WHEN SAFE_CAST(src.original_pos_terminal_id AS INT64) <= 9999
                   THEN SAFE_CAST(src.original_pos_terminal_id AS INT64) ELSE 0 END
        ) * 10000000000
        + CASE WHEN SAFE_CAST(src.original_orig_receipt_nr AS INT64) <= 9999999999
               THEN SAFE_CAST(src.original_orig_receipt_nr AS INT64) ELSE 0 END
        AS orig_sales_event_sid,
        SAFE_CAST(src.original_orig_receipt_nr AS INT64) AS orig_sales_event_nr,
        src.parent_line_nr AS parent_line_seq,
        src.voided_by_line_nr AS cancel_line_seq,
        src.context_country AS context_country,
        src.lidlplus_customer_cd AS lidlplus_customer_cd,
        src.orig_receipt_nr AS orig_receipt_nr,
        src.orig_store_nr AS orig_store_nr,
        src.original_dat_formdate AS original_dat_formdate,
        src.original_orig_store_nr AS original_orig_store_nr,
        src.original_orig_receipt_nr AS original_orig_receipt_nr,
        src.original_pos_terminal_id AS original_pos_terminal_id,
        src.receipt_business_date AS receipt_business_date,
        src.return_reason_cd AS return_reason_cd,
        src.pos_terminal_id AS pos_terminal_id,
        src.orig_item_nr,
        'EJR' AS source_system,
        CURRENT_DATE() AS extraction_dt,
        CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        't_${SRC_INPUT_TABLE}' AS filename,
        'EJR' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id
FROM ldl_data_production_etl.t_${src_input_table} src
LEFT JOIN ldl_data_production_meta.t_product_variant_key_2 AS pvk1
    ON pvk1.prod_variant_key_type_cd = 'SLS_GTIN'
   AND UPPER(CAST(SAFE_CAST(src.orig_item_nr AS INT64) AS STRING) || '|' || src.barcode)
       = UPPER(pvk1.prod_variant_nat_key_nr)
   AND pvk1.dwh_valid_fg = TRUE
LEFT JOIN ldl_data_production_core_rel.t_product_variant_2 AS pv1
    ON pvk1.prod_variant_sid = pv1.prod_variant_sid
   AND pv1.dwh_valid_fg = TRUE
LEFT JOIN ldl_data_production_meta.t_product_variant_key_2 AS pvk2
    ON pvk2.prod_variant_key_type_cd = 'SLS_UNK'
   AND UPPER(src.country_org_cd || '|' || CAST(SAFE_CAST(src.orig_item_nr AS INT64) AS STRING))
       = pvk2.prod_variant_nat_key_nr
   AND pvk2.dwh_valid_fg = TRUE
LEFT JOIN ldl_data_production_core_rel.t_product_variant_2 AS pv2
    ON pvk2.prod_variant_sid = pv2.prod_variant_sid
   AND pv2.dwh_valid_fg = TRUE
WHERE receiptline_transactiontype_id IN
    ('101','102','120','121','122','123','141','142','170','172','180','182',
     '201','202','220','221','222','223','270','272','280','282')
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY
        country_org_cd,
        orig_store_nr,
        pos_terminal_id,
        orig_receipt_nr,
        receipt_business_date,
        posnr,
        receiptline_timestamp_begin
    ORDER BY receipt_timestamp_end DESC
) = 1;


/* PRODUCT_VARIANT_SID Notes:

Mapping specifies that 
- A SID should be assigned from SLS_GTIN where the item_2 number and barcode has been assigned a SID already in the keyspace
        - Otherwise a SLS_UNK SID should be assigned from the country_2 and item_2 number has ben assigned already
                - Otherwise create a SLS_UNK SID and assign that number for the country_2 & Item_2 Number.

The previous process has assigned an SLS_GTIN SID if one was present, otherwise this process will see -1
So for -1 SIDs perform the keyspace ASSIGN_WHEN_PRESENT-ELSE-INSERT-AND-ASSIGN routine here in the transform itself

*/

BEGIN TRANSACTION;

DELETE FROM ldl_data_production_meta.t_product_variant_key_2
WHERE FALSE;

-- Create new SK entries for every new NK/TYPE/VALID_FROM_TMSP Combination

INSERT INTO ldl_data_production_meta.t_product_variant_key_2
(
    prod_variant_sid,
    prod_variant_key_type_cd,
    prod_variant_nat_key_nr,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    dwh_node_cd,
    dwh_load_id
)
SELECT
    max_seq.max_seq + ROW_NUMBER() OVER (ORDER BY 1) AS prod_variant_sid,
    'SLS_UNK',
    UPPER(t1.country_org_cd || '|' || t1.orig_item_nr) AS natural_key,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
    CURRENT_TIMESTAMP() AS dwh_valid_from_tmsp,
    TIMESTAMP('9999-12-31 23:59:59') AS dwh_valid_to_tmsp,
    TRUE,
    t1.dwh_node_cd,
    '${LOAD_ID}'
FROM (
    SELECT 'EJR' AS dwh_node_cd, UPPER(country_org_cd) AS country_org_cd, orig_item_nr
    FROM ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}_set_a
    WHERE prod_variant_sid = '-1'
    GROUP BY 1,2,3
) AS t1_2     -- We only want to create SIDs where not previously assigned (-1) and not present              
CROSS JOIN (
    SELECT COALESCE(MAX(prod_variant_sid),0) AS max_seq
    FROM ldl_data_production_meta.t_product_variant_key_2
) AS max_seq
WHERE natural_key IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM ldl_data_production_meta.t_product_variant_key_2 t2
      WHERE UPPER(t2.prod_variant_key_type_cd) = 'SLS_UNK'
        AND CURRENT_TIMESTAMP() BETWEEN t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp
        AND UPPER(t2.prod_variant_nat_key_nr) = UPPER(t1.country_org_cd|| '|' || t1.orig_item_nr)
  );

COMMIT;

INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
    retail_event_sid,
    retail_event_line_seq,
    event_start_tmsp,
    event_end_tmsp,
    bus_dt,
    retail_event_end_tmsp,
    store_sid,
    country_org_sid,
    country_org_cd,
    real_estate_sid,
    cash_register_sid,
    cash_register_type_cd,
    cash_register_usg_type_cd,
    cashier_hash,
    auth_by_hash,
    cust_sid,
    prod_retail_line_type_cd,
    retail_event_line_scenario_id,
    prod_variant_sid,
    wawi_item_sid,
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
    geo_area_key_type_cd,
    tax_pct,
    curr_cd,
    turnover_relevant_fg,
    discount_fg,
    prod_entry_method_cd,
    price_entry_method_cd,
    prod_return_reason_key_type_cd,
    return_txt,
    orig_sales_event_sid,
    orig_sales_event_nr,
    parent_line_seq,
    cancel_line_seq,
    context_country,
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
    orig_item_nr,
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
    s.src.retail_event_sid,
    s.src.retail_event_line_seq,
    s.src.event_start_tmsp,
    s.src.event_end_tmsp,
    s.src.bus_dt,
    s.src.retail_event_end_tmsp,
    s.src.store_sid,
    s.src.country_org_sid,
    s.src.country_org_cd,
    s.src.real_estate_sid,
    s.src.cash_register_sid,
    s.src.cash_register_type_cd,
    s.src.cash_register_usg_type_cd,
    s.src.cashier_hash,
    s.src.auth_by_hash,
    s.src.cust_sid,
    s.src.prod_retail_line_type_cd,
    s.src.retail_event_line_scenario_id,
    CASE
        WHEN s.src.prod_variant_sid = '-1'
        THEN pvk.prod_variant_sid       -- See start of script ^^
        ELSE s.src.prod_variant_sid     --SID would be populated where already present in SLS_GTIN Domain.
    END AS prod_variant_sid,
    COALESCE(wik.wawi_item_sid, -1) AS wawi_item_sid,
    s.src.local_prod_nr,
    s.src.prod_variant_input_nr,
    s.src.prod_variant_input_nr_type_cd,
    s.src.displayed_prod_variant_name,
    s.src.weight_based_fg,
    s.src.prod_variant_cnt,
    s.src.prod_variant_qty,
    s.src.uom_cd,
    s.src.unit_price,
    s.src.base_gross_val,
    s.src.retail_line_gross_val,
    s.src.retail_line_net_val,
    s.src.retail_line_vat_val,
    s.src.tax_class_cd,
    s.src.geo_area_key_type_cd,
    s.src.tax_pct,
    s.src.curr_cd,
    s.src.turnover_relevant_fg,
    CASE WHEN s.src.base_gross_val > s.src.retail_line_gross_val THEN TRUE ELSE FALSE END AS discount_fg,
    s.src.prod_entry_method_cd,
    s.src.price_entry_method_cd,
    s.src.prod_return_reason_key_type_cd,
    s.src.return_txt,
    s.src.orig_sales_event_sid,
    s.src.orig_sales_event_nr,
    s.src.parent_line_seq,
    s.src.cancel_line_seq,
    s.src.context_country,
    s.src.lidlplus_customer_cd,
    s.src.orig_receipt_nr,
    s.src.orig_store_nr,
    s.src.original_dat_formdate,
    s.src.original_orig_store_nr,
    s.src.original_orig_receipt_nr,
    s.src.original_pos_terminal_id,
    s.src.receipt_business_date,
    s.src.return_reason_cd,
    s.src.pos_terminal_id,
    s.src.orig_item_nr,
    'EJR' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'EJR' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}_set_a s
LEFT JOIN ldl_data_production_meta.t_product_variant_key_2 pvk        -- NKC is ON, but we dont want to generate missing keys, so we access the keyspace directly here instead os fwork-based key assignment
    ON pvk.prod_variant_key_type_cd = 'SLS_UNK'
   AND UPPER(s.src.country_org_cd || '|' || CAST(s.src.orig_item_nr AS STRING))
       = UPPER(pvk.prod_variant_nat_key_nr)
   AND pvk.dwh_valid_fg = TRUE
LEFT JOIN ldl_data_production_meta.t_wawi_item_key_2 wik
    ON UPPER(CASE WHEN s.src.country_org_cd = 'CS' THEN 'ES' ELSE s.src.country_org_cd END
             || '|' || CAST(s.src.orig_item_nr AS STRING)) = wik.wawi_item_nat_key_nr
   AND wik.wawi_item_key_type_cd = 'WAWI'
   AND s.src.bus_dt BETWEEN wik.dwh_valid_from_tmsp AND wik.dwh_valid_to_tmsp;
