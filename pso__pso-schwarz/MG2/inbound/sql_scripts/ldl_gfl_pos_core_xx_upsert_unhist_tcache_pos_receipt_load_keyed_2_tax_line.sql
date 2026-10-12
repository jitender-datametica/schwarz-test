INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
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
        retail_event_sid,
        posnr AS retail_event_line_seq,
        COALESCE(receiptline_timestamp_begin, receipt_timestamp_end) AS event_tmsp,
        receipt_business_date AS bus_dt,
        store_sid,
        country_org_sid,
        country_org_cd,
        real_estate_sid,
        cash_register_sid,
        POS_TYPE AS cash_register_type_cd,
        NULL AS cash_register_usg_type_cd,
        checker_hash AS cashier_hash,        
        cust_sid,
        CASE WHEN Try_Cast(type_vat AS Number) BETWEEN 1 AND 9 THEN Chr(64 + type_vat)
             ELSE '@'
        END AS tax_class_cd,
        geo_area_sid,
        pct_vat AS tax_pct,
        price_sum_retail AS gross_val,
        val_vat AS tax_val,
        curr_cd,
        --****************
        'EJR' AS source_system,
        CURRENT_DATE AS extraction_dt,
        current_timestamp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        'V_${SRC_INPUT_TABLE}' AS filename,
        'EJR' AS dwh_node_cd,
        '${LOAD_ID}' as dwh_load_id 
FROM ${TEMP_DB}.V_${SRC_INPUT_TABLE} src
JOIN meta.t_geographical_area_key g ON g.geo_area_key_type_cd = 'CTRY' AND UPPER(src.context_country)=UPPER(g.geo_area_nat_key_nr)
WHERE receiptline_transactiontype_id IN ('855')
QUALIFY Row_Number() OVER (  PARTITION BY
        context_country
      , orig_store_nr
      , pos_terminal_id
      , orig_receipt_nr
      , receipt_business_date
      , posnr
      , receiptline_timestamp_begin
      ORDER BY receipt_timestamp_end DESC
) = 1
;

