CREATE TEMP TABLE vt_$_2{src2tgt_temp_table1}_${src_context_area}_process AS
SELECT *
FROM ldl_data_production_etl.t_${src_input_table} src
WHERE LOWER(context_country) IN (${src_country_list})
  AND receipt_transactiontype_id BETWEEN '100' AND '399'
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY
          context_country
        , orig_store_nr
        , pos_terminal_id
        , orig_receipt_nr
        , receipt_business_date
    ORDER BY
          receipt_timestamp_end DESC
        , posnr
) = 1;

INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
        retail_event_sid,
        cash_register_event_nr,
        event_start_tmsp,
        event_end_tmsp,
        bus_dt,
        cash_register_type_cd,
        cash_register_usg_type_cd,
        cashier_nr,
        auth_by_nr,
        cust_ident_type_cd,
        retail_event_type_cd,
        retail_event_scenario_id,
        offline_fg,
        cancel_fg,
        suspend_fg,
        training_fg,
        txn_gross_val,
        txn_net_val,
        txn_vat_val,
        turnover_relevant_fg,
        service_tm_sec_meas,
        paym_tm_sec_meas,
        scanned_lines_cnt,
        keyed_lines_cnt,
        retail_event_key_type_cd,
        store_key_type_cd,
        country_org_key_type_cd,
        cust_key_type_cd,
        cont_retail_event_key_type_cd,
        cash_register_key_type_cd,
        real_estate_key_type_cd,
        context_country,
        lidlplus_customer_cd,
        orig_receipt_nr,
        orig_store_nr,
        pos_terminal_id,
        receipt_business_date,
        resumed_trans_date,
        resumed_trans_receipt_nr,
        resumed_trans_store_nr,
        resumed_trans_terminal_id,
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
    (
        (
            (
                (CAST(FORMAT_DATE('%Y%m%d', receipt_business_date) AS INT64) * 100
                 + ASCII(SUBSTR(bic_zmlila, 1, 1)))
                * 100
                + ASCII(SUBSTR(bic_zmlila, 2, 1))
            ) * 100000000
            + orig_store_nr
        ) * 10000
        + pos_terminal_id
    ) * 10000000000
    + orig_receipt_nr AS retail_event_sid,

    src.orig_receipt_nr AS cash_register_event_nr,
    src.receipt_timestamp_begin AS event_start_tmsp,
    src.receipt_timestamp_end AS event_end_tmsp,
    src.receipt_business_date AS bus_dt,
    NULL AS cash_register_type_cd,
    NULL AS cash_register_usg_type_cd,
    -1 AS cashier_nr,
    -1 AS auth_by_nr,
    src.lidlplus_ident_type_cd AS cust_ident_type_cd,

    CASE
        WHEN SUBSTR(src.receipt_transactiontype_id, 2, 1) = '5'
            THEN 'R' -- RETURN … 150, 151, 250, 251, 350, 351
        ELSE 'S'     -- SALES_2 … 100, 101, 200, 201, 300, 301
    END AS retail_event_type_cd,

    CAST(src.receipt_transactiontype_id AS INT64) AS retail_event_scenario_id,

    CASE WHEN src.offline_fg = '1' THEN TRUE ELSE FALSE END AS offline_fg,

    CASE WHEN SUBSTR(src.receipt_transactiontype_id, 1, 1) = '2' 
         THEN TRUE      /*200, 201, 250, 251*/
         ELSE FALSE END AS cancel_fg,

    CASE WHEN SUBSTR(src.receipt_transactiontype_id, 1, 1) = '3' 
         THEN TRUE      /*300, 301, 350, 351*/
         ELSE FALSE END AS suspend_fg,

    CASE WHEN src.training_fg = '1' THEN TRUE ELSE FALSE END AS training_fg,

    src.val_retail AS txn_gross_val,
    src.val_retail_net AS txn_net_val,
    src.val_retail - src.val_retail_net AS txn_vat_val,

    CASE WHEN src.receipt_transactiontype_id IN ('100','150')
         THEN TRUE ELSE FALSE END AS turnover_relevant_fg,

    (src.dur_service_time / 1000) AS service_tm_sec_meas,
    (src.dur_pay_change_time / 1000) AS paym_tm_sec_meas,

    NULL AS scanned_lines_cnt,
    NULL AS keyed_lines_cnt,

    'STORE' AS store_key_type_cd,
    'COUNTRY_2' AS country_org_key_type_cd,
    'CUST' AS cust_key_type_cd,
    'RET' AS cont_retail_event_key_type_cd,
    'REG' AS cash_register_key_type_cd,
    'RE_2' AS real_estate_key_type_cd,

    src.context_country,
    src.lidlplus_customer_cd,
    src.orig_receipt_nr,
    src.orig_store_nr,
    src.pos_terminal_id,
    src.receipt_business_date,
    src.resumed_trans_date,
    src.resumed_trans_receipt_nr,
    src.resumed_trans_store_nr,
    src.resumed_trans_terminal_id,

    'EJR' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'EJR' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id

FROM vt_$_2{src2tgt_temp_table1}_${src_context_area}_process src;

-- Delete those records from source using the PK
DELETE FROM ldl_data_production_etl.t_${src_input_table} src
WHERE EXISTS (
    SELECT 1
    FROM vt_$_2{src2tgt_temp_table1}_${src_context_area}_process process
    WHERE src.context_country = process.context_country
      AND src.orig_store_nr = process.orig_store_nr
      AND src.pos_terminal_id = process.pos_terminal_id
      AND src.orig_receipt_nr = process.orig_receipt_nr
      AND src.receipt_business_date = process.receipt_business_date
);
