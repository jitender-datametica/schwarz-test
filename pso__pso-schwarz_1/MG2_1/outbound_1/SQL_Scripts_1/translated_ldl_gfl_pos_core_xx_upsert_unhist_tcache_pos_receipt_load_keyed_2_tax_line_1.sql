INSERT INTO ldl_data_production_$_1{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
        retail_event_sid,
        retail_event_line_seq,
        event_tmsp,
        bus_dt,
        store_sid,
        country_org_sid,
        country_org_cd,
        real_estate_sid,
        cash_register_sid,
        cash_register_type_cd,
        cash_register_usg_type_cd,
        cashier_hash,
        cust_sid,
        tax_class_cd,
        geo_area_sid,
        tax_pct,
        gross_val,
        tax_val,
        curr_cd,
        --****************
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
        dedup.retail_event_sid,
        dedup.posnr AS retail_event_line_seq,
        dedup.event_tmsp,
        dedup.bus_dt,
        dedup.store_sid,
        dedup.country_org_sid,
        dedup.country_org_cd,
        dedup.real_estate_sid,
        dedup.cash_register_sid,
        dedup.cash_register_type_cd,
        dedup.cash_register_usg_type_cd,
        dedup.checker_hash AS cashier_hash,
        dedup.cust_sid,
        CASE 
            WHEN SAFE_CAST(dedup.type_vat AS INT64) BETWEEN 1 AND 9 
            THEN CODE_POINTS_TO_STRING([64 + SAFE_CAST(dedup.type_vat AS INT64)])
            ELSE '@'
        END AS tax_class_cd,
        dedup.geo_area_sid,
        dedup.pct_vat AS tax_pct,
        dedup.price_sum_retail AS gross_val,
        dedup.val_vat AS tax_val,
        dedup.curr_cd,
        --****************
        'EJR' AS source_system,
        CURRENT_DATE() AS extraction_dt,
        CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        'V_${SRC_INPUT_TABLE}' AS filename,
        'EJR' AS dwh_node_cd,
        '${LOAD_ID}' AS dwh_load_id
FROM (
    SELECT
        src.retail_event_sid,
        src.posnr,
        COALESCE(src.receiptline_timestamp_begin, src.receipt_timestamp_end) AS event_tmsp,
        src.receipt_business_date AS bus_dt,
        src.store_sid,
        src.country_org_sid,
        src.country_org_cd,
        src.real_estate_sid,
        src.cash_register_sid,
        src.pos_type AS cash_register_type_cd,
        NULL AS cash_register_usg_type_cd,
        src.checker_hash,
        src.cust_sid,
        src.type_vat,
        src.geo_area_sid,
        src.pct_vat,
        src.price_sum_retail,
        src.val_vat,
        src.curr_cd,
        src.context_country,
        src.orig_store_nr,
        src.pos_terminal_id,
        src.orig_receipt_nr,
        src.receipt_business_date,
        src.receipt_timestamp_end,
        src.posnr AS dedup_posnr,
        ROW_NUMBER() OVER (
            PARTITION BY
                src.context_country,
                src.orig_store_nr,
                src.pos_terminal_id,
                src.orig_receipt_nr,
                src.receipt_business_date,
                src.posnr,
                COALESCE(src.receiptline_timestamp_begin, src.receipt_timestamp_end)
            ORDER BY
                src.receipt_timestamp_end DESC
        ) AS rn
    FROM ldl_data_production_$_1{temp_db}.v_${src_input_table} AS src
    JOIN ldl_data_production_meta.t_geographical_area_key_1 AS g
      ON g.geo_area_key_type_cd = 'CTRY'
     AND UPPER(src.context_country) = UPPER(g.geo_area_nat_key_nr)
    WHERE src.receiptline_transactiontype_id IN ('855')
) AS dedup
WHERE dedup.rn = 1
;
