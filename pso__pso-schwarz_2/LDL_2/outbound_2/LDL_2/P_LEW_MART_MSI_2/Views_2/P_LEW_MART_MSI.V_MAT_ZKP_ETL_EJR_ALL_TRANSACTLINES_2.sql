/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_msi.v_mat_zkp_etl_ejr_all_transactlines_2
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding,Michael           Initial
#  1.1  12.01.2018    Michael Ueding           Trim Orig Attribute
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  13.02.2019    Thole,Jens               renaming discount_id zu discount_sid
#  1.4  14.03.2019    Meister,Ulrich           Umstellung DDL zur Verwendung in Rollback-fähigen Patches
#  1.5  27.07.2023    Wandtke,Andrzej          AP0177530: fill the values for timestamp_begin_ejr instead of NULL for subtotals
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_all_transactlines_2 AS
-- The condition for the relevant stores is already applied at the source table.

-- The condition for the relevant stores is already applied at the source table.

-- The condition for the relevant stores is already applied at the source table.

-- The condition for the relevant stores is already applied at the source table.

-- The condition for the relevant stores is already applied at the source table.

-- The condition for the relevant stores is already applied at the source table.

-- The condition for the relevant stores is already applied at the source table.
 SELECT x.client_id,
 x.orig_receipt_serial_nr_ejr,
 x.store_id,
 x.pos_terminal_id,
 x.dat_formdate,
 x.time_receipt_ejr,
 x.barcode,
 x.time_halfhour_id,
 x.orig_receipt_nr_ejr,
 x.timezone_cd,
 x.dat_dayend,
 x.checker_id,
 x.transactiontype_id,
 x.item_id,
 x.mainitemgroup_id,
 x.qty_piece_ejr,
 x.qty_weight_ejr,
 x.price_retail_ejr,
 x.price_retail_adjstd_ejr,
 x.price_retail_net_adjstd_ejr,
 x.price_type_ejr,
 x.mis_weight_fg,
 x.val_retail_ejr,
 x.val_retail_net_ejr,
 x.val_discount_ejr,
 x.val_discount_net_ejr,
 x.discount_sid,
 x.val_retail_orig_ejr,
 x.val_discount_base_ejr,
 x.qty_discount_pos_ejr,
 x.qty_discount_hq_ejr,
 x.return_reason_cd_ejr,
 x.timestamp_begin_ejr,
 x.timestamp_end_ejr,
 x.item_entry_method_cd_ejr,
 x.price_entry_method_cd_ejr,
 x.parent_line_nr_ejr,
 x.voided_by_line_nr_ejr,
 x.val_vat_base_ejr,
 x.val_vat_ejr,
 x.pct_vat_ejr,
 x.cnt_payment_ejr,
 'EUR' AS currency_iso_cd,
 Y.transactiontype_id AS header_transactiontype_id,
 Y.scenario_id,
 x.tendertype_cd_ejr,
 Y.cy_week,
 Y.cy_month,
 TRIM(x.original_orig_store_nr_ejr) AS original_orig_store_nr_ejr,
 x.original_dat_formdate_ejr,
 TRIM(x.original_orig_receipt_nr_ejr) AS original_orig_receipt_nr_ejr,
 TRIM(x.original_pos_terminal_id_ejr) AS original_pos_terminal_id_ejr,
 x.authority_id
FROM (SELECT client_id,
    orig_receipt_serial_nr_ejr,
    store_id,
    pos_terminal_id,
    dat_formdate,
    time_receipt_ejr,
    barcode,
      EXTRACT(HOUR FROM time_receipt_ejr) * 100 + CASE
      WHEN EXTRACT(MINUTE FROM time_receipt_ejr) < 30
      THEN 0
      ELSE 30
      END AS time_halfhour_id,
    orig_receipt_nr_ejr,
    timezone_cd,
    dat_dayend,
    checker_id,
    transactiontype_id,
    item_id,
    mainitemgroup_id,
     CASE
     WHEN mis_weight_fg = 0
     THEN qty_piece_ejr
     ELSE 0
     END AS qty_piece_ejr,
     CASE
     WHEN mis_weight_fg = 1
     THEN qty_weight_ejr
     ELSE 0
     END AS qty_weight_ejr,
    price_retail_ejr,
    price_retail_adjstd_ejr,
    ROUND(CAST(price_retail_adjstd_ejr * (100 / CASE
          WHEN 100 + pct_vat_ejr = 0
          THEN NULL
          ELSE 100 + pct_vat_ejr
          END) AS NUMERIC), 5) AS price_retail_net_adjstd_ejr,
    price_type_ejr,
    mis_weight_fg,
    val_retail_ejr,
     val_retail_ejr - val_vat_ejr AS val_retail_net_ejr,
    val_discount_ejr,
    ROUND(CAST(val_discount_ejr * (100 / CASE
          WHEN 100 + pct_vat_ejr = 0
          THEN NULL
          ELSE 100 + pct_vat_ejr
          END) AS NUMERIC), 5) AS val_discount_net_ejr,
    discount_sid,
    val_retail_orig_ejr,
    val_discount_base_ejr,
    qty_discount_pos_ejr,
    qty_discount_hq_ejr,
     CASE
     WHEN return_reason_cd_ejr IS NULL
     THEN SUBSTR('1 ', 1, 2)
     ELSE return_reason_cd_ejr
     END AS return_reason_cd_ejr,
    timestamp_begin_ejr,
    timestamp_end_ejr,
    item_entry_method_cd_ejr,
    price_entry_method_cd_ejr,
    parent_line_nr_ejr,
    voided_by_line_nr_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_base_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_ejr,
    CAST(NULL AS NUMERIC) AS pct_vat_ejr,
    0 AS cnt_payment_ejr,
    SUBSTR('11', 1, 2) AS tendertype_cd_ejr,
    COALESCE(original_orig_store_nr_ejr, '-1') AS original_orig_store_nr_ejr,
    original_dat_formdate_ejr,
    original_orig_receipt_nr_ejr,
    original_pos_terminal_id_ejr,
    authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 AS RLTR
   UNION ALL
   SELECT client_id,
    orig_receipt_serial_nr_ejr,
    store_id,
    pos_terminal_id,
    dat_formdate,
    time_receipt_ejr,
    barcode,
      EXTRACT(HOUR FROM time_receipt_ejr) * 100 + CASE
      WHEN EXTRACT(MINUTE FROM time_receipt_ejr) < 30
      THEN 0
      ELSE 30
      END AS time_halfhour_id,
    orig_receipt_nr_ejr,
    timezone_cd,
    dat_dayend,
    checker_id,
    transactiontype_id,
    item_id,
    mainitemgroup_id,
     CASE
     WHEN mis_weight_fg = 0
     THEN qty_piece_ejr
     ELSE 0
     END AS qty_piece_ejr,
     CASE
     WHEN mis_weight_fg = 1
     THEN qty_weight_ejr
     ELSE 0
     END AS qty_weight_ejr,
    price_retail_ejr,
    price_retail_adjstd_ejr,
    ROUND(CAST(price_retail_adjstd_ejr * (100 / CASE
          WHEN 100 + pct_vat_ejr = 0
          THEN NULL
          ELSE 100 + pct_vat_ejr
          END) AS NUMERIC), 5) AS price_retail_net_adjstd_ejr,
    price_type_ejr,
    mis_weight_fg,
    val_retail_ejr,
     val_retail_ejr - val_vat_ejr AS val_retail_net_ejr,
    val_discount_ejr,
    ROUND(CAST(val_discount_ejr * (100 / CASE
          WHEN 100 + pct_vat_ejr = 0
          THEN NULL
          ELSE 100 + pct_vat_ejr
          END) AS NUMERIC), 5) AS val_discount_net_ejr,
    discount_sid,
    val_retail_orig_ejr,
    val_discount_base_ejr,
    qty_discount_pos_ejr,
    qty_discount_hq_ejr,
     CASE
     WHEN return_reason_cd_ejr IS NULL
     THEN SUBSTR('1 ', 1, 2)
     ELSE return_reason_cd_ejr
     END AS return_reason_cd_ejr,
    timestamp_begin_ejr,
    timestamp_end_ejr,
    item_entry_method_cd_ejr,
    price_entry_method_cd_ejr,
    parent_line_nr_ejr,
    voided_by_line_nr_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_base_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_ejr,
    CAST(NULL AS NUMERIC) AS pct_vat_ejr,
    0 AS cnt_payment_ejr,
    SUBSTR('11', 1, 2) AS tendertype_cd_ejr,
    '-1' AS original_orig_store_nr_ejr,
    dat_formdate AS original_dat_formdate_ejr,
    '' AS original_orig_receipt_nr_ejr,
    '' AS original_pos_terminal_id_ejr,
    authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_ntr_extract_2 AS RLNTR
   UNION ALL
   SELECT client_id,
    orig_receipt_serial_nr_ejr,
    store_id,
    pos_terminal_id,
    dat_formdate,
    time_receipt_ejr,
    '' AS barcode,
    CAST(NULL AS BIGNUMERIC) AS time_halfhour_id,
    orig_receipt_nr_ejr,
    timezone_cd,
    dat_dayend,
    checker_id,
    transactiontype_id,
    CAST(- 1000 - client_id AS BIGNUMERIC) AS item_id,
    CAST(NULL AS BIGNUMERIC) AS mainitemgroup_id,
    CAST(NULL AS NUMERIC) AS qty_piece_ejr,
    CAST(NULL AS NUMERIC) AS qty_weight_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_adjstd_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_net_adjstd_ejr,
    SUBSTR(' ', 1, 1) AS price_type_ejr,
    CAST(- 1 AS BIGNUMERIC) AS mis_weight_fg,
    CAST(NULL AS NUMERIC) AS val_retail_ejr,
    CAST(NULL AS NUMERIC) AS val_retail_net_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_net_ejr,
    CAST(- 1 AS BIGNUMERIC) AS discount_sid,
    CAST(NULL AS NUMERIC) AS val_retail_orig_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_base_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_pos_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_hq_ejr,
    SUBSTR('1 ', 1, 2) AS return_reason_cd_ejr,
    timestamp_begin_ejr,
    CAST(' ' AS DATETIME) AS timestamp_end_ejr,
    SUBSTR('  ', 1, 2) AS item_entry_method_cd_ejr,
    SUBSTR('  ', 1, 2) AS price_entry_method_cd_ejr,
    CAST(NULL AS BIGNUMERIC) AS parent_line_nr_ejr,
    CAST(NULL AS BIGNUMERIC) AS voided_by_line_nr_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_base_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_ejr,
    CAST(NULL AS NUMERIC) AS pct_vat_ejr,
    0 AS cnt_payment_ejr,
    SUBSTR('11', 1, 2) AS tendertype_cd_ejr,
    '-1' AS original_orig_store_nr_ejr,
    dat_formdate AS original_dat_formdate_ejr,
    '' AS original_orig_receipt_nr_ejr,
    '' AS original_pos_terminal_id_ejr,
    authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_subtotal_extract_2 AS STTL
   UNION ALL
   SELECT client_id,
    orig_receipt_serial_nr_ejr,
    store_id,
    pos_terminal_id,
    dat_formdate,
    time_receipt_ejr,
    '' AS barcode,
    CAST(NULL AS BIGNUMERIC) AS time_halfhour_id,
    orig_receipt_nr_ejr,
    timezone_cd,
    dat_dayend,
    checker_id,
    transactiontype_id,
    CAST(- 1000 - client_id AS BIGNUMERIC) AS item_id,
    CAST(NULL AS BIGNUMERIC) AS mainitemgroup_id,
    CAST(NULL AS NUMERIC) AS qty_piece_ejr,
    CAST(NULL AS NUMERIC) AS qty_weight_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_adjstd_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_net_adjstd_ejr,
    SUBSTR(' ', 1, 1) AS price_type_ejr,
    CAST(- 1 AS BIGNUMERIC) AS mis_weight_fg,
    CAST(NULL AS NUMERIC) AS val_retail_ejr,
    CAST(NULL AS NUMERIC) AS val_retail_net_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_net_ejr,
    CAST(- 1 AS BIGNUMERIC) AS discount_sid,
    CAST(NULL AS NUMERIC) AS val_retail_orig_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_base_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_pos_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_hq_ejr,
    SUBSTR('1 ', 1, 2) AS return_reason_cd_ejr,
    CAST(' ' AS DATETIME) AS timestamp_begin_ejr,
    CAST(' ' AS DATETIME) AS timestamp_end_ejr,
    SUBSTR('  ', 1, 2) AS item_entry_method_cd_ejr,
    SUBSTR('  ', 1, 2) AS price_entry_method_cd_ejr,
    CAST(NULL AS BIGNUMERIC) AS parent_line_nr_ejr,
    CAST(NULL AS BIGNUMERIC) AS voided_by_line_nr_ejr,
    val_vat_base_ejr,
    val_vat_ejr,
    pct_vat_ejr,
    0 AS cnt_payment_ejr,
    SUBSTR('11', 1, 2) AS tendertype_cd_ejr,
    '-1' AS original_orig_store_nr_ejr,
    dat_formdate AS original_dat_formdate_ejr,
    '' AS original_orig_receipt_nr_ejr,
    '' AS original_pos_terminal_id_ejr,
    '' AS authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_tax_extract_2 AS TAX
   UNION ALL
   SELECT client_id,
    1 AS orig_receipt_serial_nr_ejr,
    store_id,
    pos_terminal_id,
    dat_formdate,
    time_receipt_ejr,
    '' AS barcode,
    CAST(NULL AS BIGNUMERIC) AS time_halfhour_id,
    orig_receipt_nr_ejr,
    timezone_cd,
    dat_dayend,
    checker_id,
    transactiontype_id,
    CAST(- 1000 - client_id AS BIGNUMERIC) AS item_id,
    CAST(NULL AS BIGNUMERIC) AS mainitemgroup_id,
    CAST(NULL AS NUMERIC) AS qty_piece_ejr,
    CAST(NULL AS NUMERIC) AS qty_weight_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_adjstd_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_net_adjstd_ejr,
    SUBSTR(' ', 1, 1) AS price_type_ejr,
    CAST(- 1 AS BIGNUMERIC) AS mis_weight_fg,
    CAST(NULL AS NUMERIC) AS val_retail_ejr,
    CAST(NULL AS NUMERIC) AS val_retail_net_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_net_ejr,
    CAST(- 1 AS BIGNUMERIC) AS discount_sid,
    CAST(NULL AS NUMERIC) AS val_retail_orig_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_base_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_pos_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_hq_ejr,
    SUBSTR('1 ', 1, 2) AS return_reason_cd_ejr,
    CAST(' ' AS DATETIME) AS timestamp_begin_ejr,
    CAST(' ' AS DATETIME) AS timestamp_end_ejr,
    SUBSTR('  ', 1, 2) AS item_entry_method_cd_ejr,
    SUBSTR('  ', 1, 2) AS price_entry_method_cd_ejr,
    CAST(NULL AS BIGNUMERIC) AS parent_line_nr_ejr,
    CAST(NULL AS BIGNUMERIC) AS voided_by_line_nr_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_base_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_ejr,
    CAST(NULL AS NUMERIC) AS pct_vat_ejr,
    0 AS cnt_payment_ejr,
    SUBSTR('11', 1, 2) AS tendertype_cd_ejr,
    '-1' AS original_orig_store_nr_ejr,
    dat_formdate AS original_dat_formdate_ejr,
    '' AS original_orig_receipt_nr_ejr,
    '' AS original_pos_terminal_id_ejr,
    '' AS authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 AS CNTRT
   WHERE transactiontype_id >= '400' -- The condition for the relevant stores is already applied at the source table.

   UNION ALL
   SELECT client_id,
    1 AS orig_receipt_serial_nr_ejr,
    store_id,
    pos_terminal_id,
    dat_formdate,
    time_receipt_ejr,
    '' AS barcode,
    CAST(NULL AS BIGNUMERIC) AS time_halfhour_id,
    orig_receipt_nr_ejr,
    timezone_cd,
    dat_dayend,
    checker_id,
    transactiontype_id,
    item_id,
    mainitemgroup_id,
    1 AS qty_piece_ejr,
    CAST(NULL AS NUMERIC) AS qty_weight_ejr,
    price_retail_ejr,
    price_retail_ejr AS price_retail_adjstd_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_net_adjstd_ejr,
    SUBSTR(' ', 1, 1) AS price_type_ejr,
    CAST(- 1 AS BIGNUMERIC) AS mis_weight_fg,
    price_retail_ejr AS val_retail_ejr,
    CAST(NULL AS NUMERIC) AS val_retail_net_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_net_ejr,
    CAST(- 1 AS BIGNUMERIC) AS discount_sid,
    CAST(NULL AS NUMERIC) AS val_retail_orig_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_base_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_pos_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_hq_ejr,
    SUBSTR('1 ', 1, 2) AS return_reason_cd_ejr,
    timestamp_begin_ejr,
    timestamp_end_ejr,
    SUBSTR('  ', 1, 2) AS item_entry_method_cd_ejr,
    SUBSTR('  ', 1, 2) AS price_entry_method_cd_ejr,
    1 AS parent_line_nr_ejr,
    CAST(NULL AS BIGNUMERIC) AS voided_by_line_nr_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_base_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_ejr,
    CAST(NULL AS NUMERIC) AS pct_vat_ejr,
    0 AS cnt_payment_ejr,
    SUBSTR('11', 1, 2) AS tendertype_cd_ejr,
    '-1' AS original_orig_store_nr_ejr,
    dat_formdate AS original_dat_formdate_ejr,
    '' AS original_orig_receipt_nr_ejr,
    '' AS original_pos_terminal_id_ejr,
    '' AS authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_price_info_extract_2 AS PINF
   UNION ALL
   SELECT client_id,
    orig_receipt_serial_nr_ejr,
    store_id,
    pos_terminal_id,
    dat_formdate,
    time_receipt_ejr,
    '' AS barcode,
    CAST(NULL AS BIGNUMERIC) AS time_halfhour_id,
    orig_receipt_nr_ejr,
    timezone_cd,
    dat_dayend,
    checker_id,
    transactiontype_id,
    CAST(- 1000 - client_id AS BIGNUMERIC) AS item_id,
    CAST(NULL AS BIGNUMERIC) AS mainitemgroup_id,
    CAST(NULL AS NUMERIC) AS qty_piece_ejr,
    CAST(NULL AS NUMERIC) AS qty_weight_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_adjstd_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_net_adjstd_ejr,
    SUBSTR(' ', 1, 1) AS price_type_ejr,
    CAST(- 1 AS BIGNUMERIC) AS mis_weight_fg,
    val_retail_payment_ejr AS val_retail_ejr,
    CAST(NULL AS NUMERIC) AS val_retail_net_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_net_ejr,
    CAST(- 1 AS BIGNUMERIC) AS discount_sid,
    CAST(NULL AS NUMERIC) AS val_retail_orig_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_base_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_pos_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_hq_ejr,
    SUBSTR('1 ', 1, 2) AS return_reason_cd_ejr,
    CAST(' ' AS DATETIME) AS timestamp_begin_ejr,
    CAST(' ' AS DATETIME) AS timestamp_end_ejr,
    SUBSTR('  ', 1, 2) AS item_entry_method_cd_ejr,
    SUBSTR('  ', 1, 2) AS price_entry_method_cd_ejr,
    CAST(NULL AS BIGNUMERIC) AS parent_line_nr_ejr,
    CAST(NULL AS BIGNUMERIC) AS voided_by_line_nr_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_base_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_ejr,
    CAST(NULL AS NUMERIC) AS pct_vat_ejr,
    CAST(cnt_payment_ejr AS NUMERIC) AS cnt_payment_ejr,
    tendertype_cd_ejr,
    '-1' AS original_orig_store_nr_ejr,
    dat_formdate AS original_dat_formdate_ejr,
    '' AS original_orig_receipt_nr_ejr,
    '' AS original_pos_terminal_id_ejr,
    '' AS authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_2 AS PAYM
   UNION ALL
   SELECT client_id,
    orig_receipt_serial_nr_ejr,
    store_id,
    pos_terminal_id,
    dat_formdate,
    time_receipt_ejr,
    '' AS barcode,
    CAST(NULL AS BIGNUMERIC) AS time_halfhour_id,
    orig_receipt_nr_ejr,
    timezone_cd,
    dat_dayend,
    checker_id,
    transactiontype_id,
    CAST(- 1000 - client_id AS BIGNUMERIC) AS item_id,
    CAST(NULL AS BIGNUMERIC) AS mainitemgroup_id,
    CAST(NULL AS NUMERIC) AS qty_piece_ejr,
    CAST(NULL AS NUMERIC) AS qty_weight_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_adjstd_ejr,
    CAST(NULL AS NUMERIC) AS price_retail_net_adjstd_ejr,
    SUBSTR(' ', 1, 1) AS price_type_ejr,
    CAST(- 1 AS BIGNUMERIC) AS mis_weight_fg,
    val_retail_payment_ejr AS val_retail_ejr,
    CAST(NULL AS NUMERIC) AS val_retail_net_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_net_ejr,
    CAST(- 1 AS BIGNUMERIC) AS discount_sid,
    CAST(NULL AS NUMERIC) AS val_retail_orig_ejr,
    CAST(NULL AS NUMERIC) AS val_discount_base_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_pos_ejr,
    CAST(NULL AS NUMERIC) AS qty_discount_hq_ejr,
    SUBSTR('1 ', 1, 2) AS return_reason_cd_ejr,
    CAST(' ' AS DATETIME) AS timestamp_begin_ejr,
    CAST(' ' AS DATETIME) AS timestamp_end_ejr,
    SUBSTR('  ', 1, 2) AS item_entry_method_cd_ejr,
    SUBSTR('  ', 1, 2) AS price_entry_method_cd_ejr,
    CAST(NULL AS BIGNUMERIC) AS parent_line_nr_ejr,
    CAST(NULL AS BIGNUMERIC) AS voided_by_line_nr_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_base_ejr,
    CAST(NULL AS NUMERIC) AS val_vat_ejr,
    CAST(NULL AS NUMERIC) AS pct_vat_ejr,
    CAST(cnt_payment_ejr AS NUMERIC) AS cnt_payment_ejr,
    tendertype_cd_ejr,
    '-1' AS original_orig_store_nr_ejr,
    dat_formdate AS original_dat_formdate_ejr,
    '' AS original_orig_receipt_nr_ejr,
    '' AS original_pos_terminal_id_ejr,
    '' AS authority_id
   FROM ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_ntr_extract_2 AS PAYNTR) AS x
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 AS Y ON x.store_id = Y.store_id AND x.client_id
       = Y.client_id AND x.pos_terminal_id = Y.pos_terminal_id AND x.dat_formdate = Y.dat_formdate AND x.time_receipt_ejr
     = Y.time_receipt_ejr AND x.orig_receipt_nr_ejr = Y.orig_receipt_nr_ejr;