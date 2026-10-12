INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(       
        retail_event_sid,
        retail_event_line_seq,
        paym_start_tmsp,
        paym_end_tmsp,
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
        retail_event_line_scenario_id,
        paym_line_type_cd,
        local_paym_val,
        local_curr_cd,
        foreign_paym_val,
        foreign_curr_cd,
        round_diff,
        paym_type_id,
        card_txn_nr,
        paym_card_type_cd,
        card_txn_type_cd,
        card_auth_method_cd,
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
        COALESCE(receiptline_timestamp_begin,receiptline_timestamp_end) AS paym_start_tmsp,
        receiptline_timestamp_end AS paym_end_tmsp,
        receipt_business_date AS bus_dt,
        store_sid,
        country_org_sid,
        src.country_org_cd,
        real_estate_sid,
        cash_register_sid,
        pos_type AS cash_register_type_cd,
        NULL AS cash_register_usg_type_cd,
        checker_hash AS cashier_hash,
        cust_sid,
        receiptline_transactiontype_id AS retail_event_line_scenario_id,
        CASE WHEN posart = '4' THEN 'P'
             ELSE 'R'
        END AS paym_line_type_cd,
        price_sum_retail AS local_paym_val,
        src.curr_cd AS local_curr_cd,
        val_retail_orig AS foreign_paym_val,
        CASE WHEN val_retail_orig IS NOT NULL THEN currency_iso_cd
             ELSE NULL
        END AS foreign_curr_cd,
        val_discount_base AS round_diff,
        tendertype_cd AS paym_type_id,
        NULL AS card_txn_nr,
        NULL AS paym_card_type_cd,
        NULL AS card_txn_type_cd,
        NULL AS card_auth_method_cd,
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
WHERE receiptline_transactiontype_id IN    ('110','210')
   AND receipt_transactiontype_id between 100 and 399
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
