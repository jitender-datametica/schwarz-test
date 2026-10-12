/*
    SID generating for unknown combinations {context_country, orig_item_nr}.
    Substitute for the negative key capture.
*/
CREATE TEMP TABLE t_pos_items_tmp AS
(
    SELECT
        CASE WHEN UPPER(context_country) = 'CS' THEN 'ES' ELSE UPPER(context_country) END AS ctrcode,
        CAST(orig_item_nr AS INT64) AS item_nr,
        MIN(receipt_business_date) AS bus_dt,
        COALESCE(MIN(item_desc), 'EJR-Dummy_2') AS item_descr
    FROM ldl_data_production_$_2{temp_db}.t_${src_input_table}
    WHERE receiptline_transactiontype_id IN
         ('101','102','120','121','122','123','141','142','170','172','180','182'
         ,'201','202','220','221','222','223','270','272','280','282')
       OR receiptline_transactiontype_id IN
         ('401','402','441','442','470','472','480','482','501','502','570','572','580','582','199',
          '601','602','641','642','670','672','680','682','299','701','702','770','772','780','782')
       OR receipt_transactiontype_id = '480'
    GROUP BY 1,2
);

CREATE TEMP TABLE t_pos_items_new_tmp (
    ctrcode STRING NOT NULL,
    item_nr INT64 NOT NULL,
    start_dt DATE NOT NULL,
    item_descr STRING NOT NULL
);

BEGIN TRANSACTION;

-- Lock the tables (no-ops in BQ)
UPDATE ldl_data_production_meta.t_wawi_item_key_2         SET wawi_item_sid = -1 WHERE 0 = 1;
UPDATE ldl_data_production_meta.t_wawi_item_variant_key_2 SET wawi_item_variant_sid = -1 WHERE 0 = 1;
UPDATE ldl_data_production_core_rel.t_wawi_item_2         SET wawi_item_sid = -1 WHERE 0 = 1;
UPDATE ldl_data_production_core_rel.t_wawi_item_variant_2 SET wawi_item_variant_sid = -1 WHERE 0 = 1;

-- Need to generate dummy_2 item_2/variant
INSERT INTO ldl_data_production_etl.t_pos_items_new_tmp
(
    ctrcode,
    item_nr,
    start_dt,
    item_descr
)
SELECT
    ctrcode,
    item_nr,
    bus_dt,
    item_descr
FROM t_pos_items_tmp
WHERE (ctrcode || '|' || CAST(item_nr AS STRING)) NOT IN
    (
        SELECT wawi_item_nat_key_nr
        FROM ldl_data_production_meta.t_wawi_item_key_2
    );

INSERT INTO ldl_data_production_meta.t_wawi_item_key_2
(
    wawi_item_sid,
    wawi_item_key_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    wawi_item_nat_key_nr,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
)
SELECT
    max_sid.max_sid + ROW_NUMBER() OVER (ORDER BY src.ctrcode, src.item_nr),
    'WAWI',
    TIMESTAMP('1900-01-01 00:00:00'),
    TIMESTAMP('9999-12-31 23:59:59'),
    TRUE,
    src.ctrcode || '|' || CAST(src.item_nr AS STRING),
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP(),
    '${LOAD_ID}',
    'EJR' -- Indication that the line was created in the EJR loading
FROM t_pos_items_new_tmp AS src
CROSS JOIN (
    SELECT COALESCE(MAX(wawi_item_sid), 0) AS max_sid
    FROM ldl_data_production_meta.t_wawi_item_key_2
) AS max_sid;

INSERT INTO ldl_data_production_meta.t_wawi_item_variant_key_2
(
    wawi_item_variant_sid,
    wawi_item_variant_key_type_cd,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    wawi_item_variant_nat_key_nr,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
)
SELECT
    max_sid.max_sid + ROW_NUMBER() OVER (ORDER BY src.ctrcode, src.item_nr),
    'WAWI',
    TIMESTAMP('1900-01-01 00:00:00'),
    TIMESTAMP('9999-12-31 23:59:59'),
    TRUE,
    src.ctrcode || '|' || CAST(src.item_nr AS STRING) || '|0',
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP(),
    '${LOAD_ID}',
    'EJR'
FROM t_pos_items_new_tmp AS src
CROSS JOIN (
    SELECT COALESCE(MAX(wawi_item_variant_sid), 0) AS max_sid
    FROM ldl_data_production_meta.t_wawi_item_variant_key_2
) AS max_sid;

INSERT INTO ldl_data_production_core_rel.t_wawi_item_2
(
    wawi_item_sid,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    country_org_sid,
    country_org_cd,
    wawi_item_nr,
    wawi_item_name,
    wawi_item_descr,
    wawi_item_creation_dt,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
)
SELECT
    wik.wawi_item_sid,
    CASE WHEN seq.seq_num = 0 THEN TIMESTAMP('1900-01-01 00:00:00') ELSE src.start_dt END,
    CASE WHEN seq.seq_num = 0 THEN TIMESTAMP_SUB(src.start_dt, INTERVAL 1 SECOND) ELSE TIMESTAMP('9999-12-31 23:59:59') END,
    seq.seq_num = 1,
    cpk.party_sid,
    cio.country_org_cd,
    src.item_nr,
    src.item_descr,
    src.item_descr,
    DATE '1900-01-01',
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP(),
    '${LOAD_ID}',
    'EJR'
FROM t_pos_items_new_tmp AS src
INNER JOIN ldl_data_production_meta.t_wawi_item_key_2 AS wik
    ON src.ctrcode || '|' || CAST(src.item_nr AS STRING) = wik.wawi_item_nat_key_nr
   AND wik.wawi_item_key_type_cd = 'WAWI'
   AND wik.dwh_valid_fg = TRUE
INNER JOIN ldl_data_production_meta.t_party_key_2 AS cpk
    ON src.ctrcode = cpk.party_nat_key_nr
   AND cpk.party_key_type_cd = 'COUNTRY_2'
   AND cpk.dwh_valid_fg = TRUE
INNER JOIN ldl_data_production_core_rel.t_internal_organization_2 AS cio
    ON cpk.party_sid = cio.int_org_sid
   AND cio.dwh_valid_fg = TRUE
CROSS JOIN UNNEST([STRUCT(0 AS seq_num),(1 AS seq_num)]) AS seq;

INSERT INTO ldl_data_production_core_rel.t_wawi_item_variant_2
(
    wawi_item_variant_sid,
    dwh_valid_from_tmsp,
    dwh_valid_to_tmsp,
    dwh_valid_fg,
    wawi_item_sid,
    country_org_sid,
    country_org_cd,
    wawi_item_variant_nr,
    wawi_item_variant_name,
    wawi_item_variant_descr,
    wawi_item_variant_creation_dt,
    case_size_cnt,
    weight_based_fg,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
)
SELECT
    wvk.wawi_item_variant_sid,
    CASE WHEN seq.seq_num = 0 THEN TIMESTAMP('1900-01-01 00:00:00') ELSE src.start_dt END,
    CASE WHEN seq.seq_num = 0 THEN TIMESTAMP_SUB(src.start_dt, INTERVAL 1 SECOND) ELSE TIMESTAMP('9999-12-31 23:59:59') END,
    seq.seq_num = 1,
    wik.wawi_item_sid,
    cpk.party_sid,
    cio.country_org_cd,
    src.item_nr * 10000,
    src.item_descr,
    src.item_descr,
    DATE '1900-01-01',
    0,
    FALSE,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP(),
    '${LOAD_ID}',
    'EJR'
FROM t_pos_items_new_tmp AS src
INNER JOIN ldl_data_production_meta.t_wawi_item_key_2 AS wik
    ON src.ctrcode || '|' || CAST(src.item_nr AS STRING) = wik.wawi_item_nat_key_nr
   AND wik.wawi_item_key_type_cd = 'WAWI'
   AND wik.dwh_valid_fg = TRUE
INNER JOIN ldl_data_production_meta.t_wawi_item_variant_key_2 AS wvk
    ON src.ctrcode || '|' || CAST(src.item_nr AS STRING) || '|0' = wvk.wawi_item_variant_nat_key_nr
   AND wvk.wawi_item_variant_key_type_cd = 'WAWI'
   AND wvk.dwh_valid_fg = TRUE
INNER JOIN ldl_data_production_meta.t_party_key_2 AS cpk
    ON src.ctrcode = cpk.party_nat_key_nr
   AND cpk.party_key_type_cd = 'COUNTRY_2'
   AND cpk.dwh_valid_fg = TRUE
INNER JOIN ldl_data_production_core_rel.t_internal_organization_2 AS cio
    ON cpk.party_sid = cio.int_org_sid
   AND cio.dwh_valid_fg = TRUE
CROSS JOIN UNNEST([STRUCT(0 AS seq_num),(1 AS seq_num)]) AS seq;

COMMIT;

-- Clean out the tcache table.
DELETE FROM ldl_data_production_$_2{target_db}.${tgt_target_table}
WHERE TRUE;

INSERT INTO ldl_data_production_$_2{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
    extraction_date,
    extraction_ts,
    bic_zmlila,
    load_id,
    receipt_transactiontype_id,
    context_load_id,
    context_country,
    orig_wh_nr,
    orig_store_nr,
    pos_terminal_id,
    checker_hash,
    orig_receipt_nr,
    orig_item_nr,
    val_retail,
    orig_cnt_scanpos,
    orig_cnt_dirpos,
    pos_type,
    dur_receipt,
    resumed_trans_store_nr,
    resumed_trans_terminal_id,
    resumed_trans_date,
    resumed_trans_receipt_nr,
    receipt_business_date,
    offline_fg,
    training_fg,
    dur_service_time,
    dur_pay_change_time,
    val_retail_net,
    receiptline_timestamp_begin,
    receiptline_timestamp_end,
    receiptline_authority_hash,
    receipt_authority_hash,
    receipt_timestamp_begin,
    receipt_timestamp_end,
    item_desc,
    lidlplus_customer_cd,
    lidlplus_ident_type_cd,
    posnr,
    posart,
    item_entry_method_cd,
    barcode,
    price_retail,
    qty_sold,
    fg_weight,
    price_sum_retail,
    pct_discount,
    val_discount,
    currency_iso_cd,
    discount_nr,
    receiptline_transactiontype_id,
    val_vat,
    price_entry_method_cd,
    parent_line_nr,
    pct_vat,
    val_discount_base,
    qty_discount_pos,
    qty_discount_hq,
    tendertype_cd,
    return_reason_cd,
    return_text,
    voided_by_line_nr,
    val_retail_orig,
    type_vat,
    original_orig_receipt_nr,
    original_pos_terminal_id,
    original_orig_store_nr,
    original_dat_formdate,
    cash_register_sid,
    country_org_sid,
    real_estate_sid,
    store_sid,
    cust_sid,
    retail_event_sid,
    country_org_cd,
    curr_cd,
    dwh_mapping_dt,
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
    src.extraction_date,
    src.extraction_ts,
    src.bic_zmlila,
    src.load_id,
    src.receipt_transactiontype_id,
    src.context_load_id,
    src.context_country,
    src.orig_wh_nr,
    src.orig_store_nr,
    src.pos_terminal_id,
    src.checker_hash,
    src.orig_receipt_nr,
    src.orig_item_nr,
    src.val_retail,
    src.orig_cnt_scanpos,
    src.orig_cnt_dirpos,
    reg.cash_register_type_cd AS pos_type,
    src.dur_receipt,
    src.resumed_trans_store_nr,
    src.resumed_trans_terminal_id,
    src.resumed_trans_date,
    src.resumed_trans_receipt_nr,
    src.receipt_business_date,
    src.offline_fg,
    src.training_fg,
    src.dur_service_time,
    src.dur_pay_change_time,
    src.val_retail_net,
    src.receiptline_timestamp_begin,
    src.receiptline_timestamp_end,
    src.receiptline_authority_hash,
    src.receipt_authority_hash,
    src.receipt_timestamp_begin,
    src.receipt_timestamp_end,
    src.item_desc,
    src.lidlplus_customer_cd,
    src.lidlplus_ident_type_cd,
    src.posnr,
    src.posart,
    src.item_entry_method_cd,
    src.barcode,
    src.price_retail,
    src.qty_sold,
    src.fg_weight,
    src.price_sum_retail,
    src.pct_discount,
    src.val_discount,
    src.currency_iso_cd,
    src.discount_nr,
    src.receiptline_transactiontype_id,
    src.val_vat,
    src.price_entry_method_cd,
    src.parent_line_nr,
    src.pct_vat,
    src.val_discount_base,
    src.qty_discount_pos,
    src.qty_discount_hq,
    src.tendertype_cd,
    src.return_reason_cd,
    src.return_text,
    src.voided_by_line_nr,
    src.val_retail_orig,
    src.type_vat,
    src.original_orig_receipt_nr,
    src.original_pos_terminal_id,
    src.original_orig_store_nr,
    src.original_dat_formdate,
    src.cash_register_sid,
    src.country_org_sid,
    src.real_estate_sid,
    src.store_sid,
    src.cust_sid,
    src.retail_event_sid,
    io.country_org_cd,
    io.curr_cd,
    src.dwh_mapping_dt,
    'EJR' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'EJR' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM ldl_data_production_$_2{temp_db}.t_${src_input_table} src
LEFT JOIN ldl_data_production_core_rel.t_internal_organization_2 io
    ON src.country_org_sid = io.int_org_sid
   AND src.receipt_business_date BETWEEN io.dwh_valid_from_tmsp AND io.dwh_valid_to_tmsp
LEFT JOIN (
    SELECT DISTINCT cash_register_type_cd
    FROM ldl_data_production_core_rel.t_cash_register_type_2
) reg
    ON src.pos_type = reg.cash_register_type_cd     -- Non-existent cash_register_types will be set to NULL (as per requirement).
WHERE COALESCE(src.pos_type,'@') <> 'FVS' -- Fruit & Veg Receipts are not really receipts
;
