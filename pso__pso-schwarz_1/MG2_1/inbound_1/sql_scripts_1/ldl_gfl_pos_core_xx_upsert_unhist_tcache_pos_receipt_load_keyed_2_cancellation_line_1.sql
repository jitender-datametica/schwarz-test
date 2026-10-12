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
        auth_by_hash,
        cust_sid,
        retail_event_line_scenario_id,
        input_cancel_nr,
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
        receiptline_timestamp_begin AS event_tmsp,
        receipt_business_date AS bus_dt,
        store_sid,
        country_org_sid,
        country_org_cd,
        real_estate_sid,
        cash_register_sid,
        pos_type as cash_register_type_cd,
        NULL AS cash_register_usg_type_cd,
        checker_hash AS cashier_hash,
        receiptline_authority_hash AS auth_by_hash,
        cust_sid,
        receiptline_transactiontype_id AS retail_event_line_scenario_id,
        barcode AS input_cancel_nr,
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
WHERE receiptline_transactiontype_id IN
    ('171','173','181','183','271','273','281','283','471','473','481','483',
     '571','573','581','583','671','673','681','683','771','773','781','783')
--QUALIFY new (temporal), keep just first cancel line with matching number  - Changed following solace switch
QUALIFY Row_Number() OVER (  PARTITION BY
        context_country
      , orig_store_nr
      , pos_terminal_id
      , orig_receipt_nr
      , receipt_business_date
      , posnr
      ORDER BY receiptline_timestamp_begin, receipt_timestamp_end DESC
) = 1
;

