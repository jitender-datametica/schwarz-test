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

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_ALL_TRANSACTLINES_2 AS
   SELECT
    x.client_id
   ,x.orig_receipt_serial_nr_ejr
   ,x.store_id
   ,x.pos_terminal_id
   ,x.dat_formdate
   ,x.time_receipt_ejr
   ,x.barcode
   ,x.time_halfhour_id
   ,x.orig_receipt_nr_ejr
   ,x.timezone_cd
   ,x.dat_dayend
   ,x.checker_id
   ,x.transactiontype_id
   ,x.item_id
   ,x.mainitemgroup_id
   ,x.qty_piece_ejr
   ,x.qty_weight_ejr
   ,x.price_retail_ejr
   ,x.price_retail_adjstd_ejr
   ,x.price_retail_net_adjstd_ejr
   ,x.price_type_ejr
   ,x.mis_weight_fg
   ,x.val_retail_ejr
   ,x.val_retail_net_ejr
   ,x.val_discount_ejr
   ,x.val_discount_net_ejr
   ,x.discount_sid
   ,x.val_retail_orig_ejr
   ,x.val_discount_base_ejr
   ,x.qty_discount_pos_ejr
   ,x.qty_discount_hq_ejr
   ,x.return_reason_cd_ejr
   ,x.timestamp_begin_ejr
   ,x.timestamp_end_ejr
   ,x.item_entry_method_cd_ejr
   ,x.price_entry_method_cd_ejr
   ,x.parent_line_nr_ejr
   ,x.voided_by_line_nr_ejr
   ,x.val_vat_base_ejr
   ,x.val_vat_ejr
   ,x.pct_vat_ejr
   ,x.cnt_payment_ejr
   ,'EUR' AS currency_iso_cd
   ,y.transactiontype_id AS header_transactiontype_id
   ,y.scenario_id
   ,x.tendertype_cd_ejr
   ,y.cy_week
   ,y.cy_month
   ,TRIM(x.original_orig_store_nr_ejr) AS original_orig_store_nr_ejr
   ,x.original_dat_formdate_ejr
   ,TRIM(x.original_orig_receipt_nr_ejr) AS original_orig_receipt_nr_ejr
   ,TRIM(x.original_pos_terminal_id_ejr) AS original_pos_terminal_id_ejr
   ,x.authority_id
   FROM
   (
       SELECT
    rltr.client_id
   ,rltr.orig_receipt_serial_nr_ejr
   ,rltr.store_id
   ,rltr.pos_terminal_id
   ,rltr.dat_formdate
   ,rltr.time_receipt_ejr
   ,rltr.barcode
   ,(EXTRACT(HOUR FROM rltr.time_receipt_ejr)*100 + (CASE WHEN (EXTRACT(MINUTE FROM (rltr.time_receipt_ejr)) < 30) THEN 0 ELSE 30 END)) AS time_halfhour_id
   ,rltr.orig_receipt_nr_ejr
   ,rltr.timezone_cd
   ,rltr.dat_dayend
   ,rltr.checker_id
   ,rltr.transactiontype_id
   ,rltr.item_id
   ,rltr.mainitemgroup_id
   ,CASE WHEN rltr.mis_weight_fg = 0
              THEN rltr.qty_piece_ejr
              ELSE 0 END AS qty_piece_ejr
   ,CASE WHEN rltr.mis_weight_fg = 1
              THEN rltr.qty_weight_ejr
              ELSE 0 END AS qty_weight_ejr
   ,rltr.price_retail_ejr
   ,rltr.price_retail_adjstd_ejr
   ,CAST(rltr.price_retail_adjstd_ejr * (100/ CASE WHEN 100+rltr.pct_vat_ejr = 0 THEN NULL ELSE 100+rltr.pct_vat_ejr END) AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr
   ,rltr.price_type_ejr
   ,rltr.mis_weight_fg
   ,rltr.val_retail_ejr
   ,rltr.val_retail_ejr - rltr.val_vat_ejr AS val_retail_net_ejr
   ,rltr.val_discount_ejr
   ,CAST(rltr.val_discount_ejr * (100/ CASE WHEN 100+rltr.pct_vat_ejr = 0 THEN NULL ELSE 100+rltr.pct_vat_ejr END) AS DECIMAL(19,5)) AS val_discount_net_ejr
   ,rltr.discount_sid
   ,rltr.val_retail_orig_ejr
   ,rltr.val_discount_base_ejr
   ,rltr.qty_discount_pos_ejr
   ,rltr.qty_discount_hq_ejr
   ,CASE WHEN rltr.return_reason_cd_ejr IS NULL
              THEN CAST('1' AS CHAR(2))
              ELSE rltr.return_reason_cd_ejr END AS return_reason_cd_ejr
   ,rltr.timestamp_begin_ejr
   ,rltr.timestamp_end_ejr
   ,rltr.item_entry_method_cd_ejr
   ,rltr.price_entry_method_cd_ejr
   ,rltr.parent_line_nr_ejr
   ,rltr.voided_by_line_nr_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_ejr
   ,CAST(NULL AS DECIMAL(9,4)) AS pct_vat_ejr
   ,CAST(0 AS DECIMAL(18,4)) AS cnt_payment_ejr
   ,CAST('11' AS CHAR(2)) tendertype_cd_ejr
   ,Coalesce(rltr.original_orig_store_nr_ejr  ,'-1') AS original_orig_store_nr_ejr
   ,rltr.original_dat_formdate_ejr
   ,rltr.original_orig_receipt_nr_ejr
   ,rltr.original_pos_terminal_id_ejr
   ,rltr.authority_id
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 rltr
   -- The condition for the relevant stores is already applied at the source table.
   UNION ALL
   SELECT
    rlntr.client_id
   ,rlntr.orig_receipt_serial_nr_ejr
   ,rlntr.store_id
   ,rlntr.pos_terminal_id
   ,rlntr.dat_formdate
   ,rlntr.time_receipt_ejr
   ,rlntr.barcode
   ,(EXTRACT(HOUR FROM rlntr.time_receipt_ejr)*100 + (CASE WHEN (EXTRACT(MINUTE FROM (rlntr.time_receipt_ejr)) < 30) THEN 0 ELSE 30 END)) AS time_halfhour_id
   ,rlntr.orig_receipt_nr_ejr
   ,rlntr.timezone_cd
   ,rlntr.dat_dayend
   ,rlntr.checker_id
   ,rlntr.transactiontype_id
   ,rlntr.item_id
   ,rlntr.mainitemgroup_id
   ,CASE WHEN rlntr.mis_weight_fg = 0
              THEN rlntr.qty_piece_ejr
              ELSE 0 END AS qty_piece_ejr
   ,CASE WHEN rlntr.mis_weight_fg = 1
              THEN rlntr.qty_weight_ejr
              ELSE 0 END AS qty_weight_ejr
   ,rlntr.price_retail_ejr
   ,rlntr.price_retail_adjstd_ejr
   ,CAST(rlntr.price_retail_adjstd_ejr * (100/ CASE WHEN 100+rlntr.pct_vat_ejr = 0 THEN NULL ELSE 100+rlntr.pct_vat_ejr END) AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr
   ,rlntr.price_type_ejr
   ,rlntr.mis_weight_fg
   ,rlntr.val_retail_ejr
   ,rlntr.val_retail_ejr - rlntr.val_vat_ejr AS val_retail_net_ejr
   ,rlntr.val_discount_ejr
   ,CAST(rlntr.val_discount_ejr * (100/ CASE WHEN 100+rlntr.pct_vat_ejr = 0 THEN NULL ELSE 100+rlntr.pct_vat_ejr END) AS DECIMAL(19,5)) AS val_discount_net_ejr
   ,rlntr.discount_sid
   ,rlntr.val_retail_orig_ejr
   ,rlntr.val_discount_base_ejr
   ,rlntr.qty_discount_pos_ejr
   ,rlntr.qty_discount_hq_ejr
   ,CASE WHEN rlntr.return_reason_cd_ejr IS NULL
              THEN CAST('1' AS CHAR(2))
              ELSE rlntr.return_reason_cd_ejr END AS return_reason_cd_ejr
   ,rlntr.timestamp_begin_ejr
   ,rlntr.timestamp_end_ejr
   ,rlntr.item_entry_method_cd_ejr
   ,rlntr.price_entry_method_cd_ejr
   ,rlntr.parent_line_nr_ejr
   ,rlntr.voided_by_line_nr_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_ejr
   ,CAST(NULL AS DECIMAL(9,4)) AS pct_vat_ejr
   ,CAST(0 AS DECIMAL(18,4)) AS cnt_payment_ejr
   ,CAST('11' AS CHAR(2)) tendertype_cd_ejr
   ,CAST('-1' AS VARCHAR(100)) AS original_orig_store_nr_ejr
   ,rlntr.dat_formdate AS original_dat_formdate_ejr
   ,CAST('' AS VARCHAR(100)) AS original_orig_receipt_nr_ejr
   ,CAST('' AS VARCHAR(100)) AS original_pos_terminal_id_ejr
   ,rlntr.authority_id
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_ntr_extract_2 rlntr
   -- The condition for the relevant stores is already applied at the source table.
   UNION ALL
   SELECT
    sttl.client_id
   ,sttl.orig_receipt_serial_nr_ejr
   ,sttl.store_id
   ,sttl.pos_terminal_id
   ,sttl.dat_formdate
   ,sttl.time_receipt_ejr
   ,CAST ('' AS VARCHAR(50)) AS barcode
   ,CAST (NULL AS INTEGER)   AS time_halfhour_id
   ,sttl.orig_receipt_nr_ejr
   ,sttl.timezone_cd
   ,sttl.dat_dayend
   ,sttl.checker_id
   ,sttl.transactiontype_id
   ,CAST((-1000 - sttl.client_id) AS INTEGER) AS item_id
   ,CAST(NULL AS INTEGER) AS mainitemgroup_id
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_piece_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_weight_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_adjstd_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr
   ,CAST('' AS CHAR(1)) AS price_type_ejr
   ,CAST(-1 AS SMALLINT) AS mis_weight_fg
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_net_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS val_discount_net_ejr
   ,CAST(-1 AS INTEGER) AS discount_sid
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_orig_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_pos_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_hq_ejr
   ,CAST('1' AS CHAR(2)) AS return_reason_cd_ejr
   ,sttl.timestamp_begin_ejr AS timestamp_begin_ejr
   ,CAST(NULL AS TIMESTAMP) AS timestamp_end_ejr
   ,CAST('' AS CHAR(2)) AS item_entry_method_cd_ejr
   ,CAST('' AS CHAR(2)) AS price_entry_method_cd_ejr
   ,CAST(NULL AS INTEGER) AS parent_line_nr_ejr
   ,CAST(NULL AS INTEGER) AS voided_by_line_nr_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_ejr
   ,CAST(NULL AS DECIMAL(9,4)) AS pct_vat_ejr
   ,CAST(0 AS DECIMAL(18,4)) AS cnt_payment_ejr
   ,CAST('11' AS CHAR(2)) tendertype_cd_ejr
   ,CAST('-1' AS VARCHAR(100)) AS original_orig_store_nr_ejr
   ,sttl.dat_formdate AS original_dat_formdate_ejr
   ,CAST('' AS VARCHAR(100)) AS original_orig_receipt_nr_ejr
   ,CAST('' AS VARCHAR(100)) AS original_pos_terminal_id_ejr
   ,sttl.authority_id
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_subtotal_extract_2 sttl
   -- The condition for the relevant stores is already applied at the source table.
   UNION ALL
   SELECT
    tax.client_id
   ,tax.orig_receipt_serial_nr_ejr
   ,tax.store_id
   ,tax.pos_terminal_id
   ,tax.dat_formdate
   ,tax.time_receipt_ejr
   ,CAST('' AS VARCHAR(50)) AS barcode
   ,CAST (NULL AS INTEGER) AS  time_halfhour_id
   ,tax.orig_receipt_nr_ejr
   ,tax.timezone_cd
   ,tax.dat_dayend
   ,tax.checker_id
   ,tax.transactiontype_id
   ,CAST((-1000 - tax.client_id) AS INTEGER) AS item_id
   ,CAST(NULL AS INTEGER) AS mainitemgroup_id
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_piece_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_weight_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_adjstd_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr
   ,CAST('' AS CHAR(1)) AS price_type_ejr
   ,CAST(-1 AS SMALLINT) AS mis_weight_fg
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_net_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS val_discount_net_ejr
   ,CAST(-1 AS INTEGER) AS discount_sid
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_orig_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_pos_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_hq_ejr
   ,CAST('1' AS CHAR(2)) AS return_reason_cd_ejr
   ,CAST(NULL AS TIMESTAMP) AS timestamp_begin_ejr
   ,CAST(NULL AS TIMESTAMP) AS timestamp_end_ejr
   ,CAST('' AS CHAR(2)) AS item_entry_method_cd_ejr
   ,CAST('' AS CHAR(2)) AS price_entry_method_cd_ejr
   ,CAST(NULL AS INTEGER) AS parent_line_nr_ejr
   ,CAST(NULL AS INTEGER) AS voided_by_line_nr_ejr
   ,tax.val_vat_base_ejr
   ,tax.val_vat_ejr
   ,tax.pct_vat_ejr
   ,CAST (0 AS DECIMAL(18,4)) AS  cnt_payment_ejr
   ,CAST ('11' AS CHAR(2)) tendertype_cd_ejr
   ,CAST('-1' AS VARCHAR(100)) AS original_orig_store_nr_ejr
   ,tax.dat_formdate AS original_dat_formdate_ejr
   ,CAST('' AS VARCHAR(100)) AS original_orig_receipt_nr_ejr
   ,CAST('' AS VARCHAR(100)) AS original_pos_terminal_id_ejr
   ,CAST('' AS VARCHAR(40)) AS authority_id
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_tax_extract_2 tax
   -- The condition for the relevant stores is already applied at the source table.
   UNION ALL
   SELECT
    cntrt.client_id
   ,CAST(1 AS INTEGER) AS  orig_receipt_serial_nr_ejr
   ,cntrt.store_id
   ,cntrt.pos_terminal_id
   ,cntrt.dat_formdate
   ,cntrt.time_receipt_ejr
   ,CAST('' AS VARCHAR(50)) AS barcode
   ,CAST (NULL AS INTEGER) AS  time_halfhour_id
   ,cntrt.orig_receipt_nr_ejr
   ,cntrt.timezone_cd
   ,cntrt.dat_dayend
   ,cntrt.checker_id
   ,cntrt.transactiontype_id
   ,CAST((-1000 - cntrt.client_id) AS INTEGER) AS item_id
   ,CAST(NULL AS INTEGER) AS mainitemgroup_id
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_piece_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_weight_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_adjstd_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr
   ,CAST('' AS CHAR(1)) AS price_type_ejr
   ,CAST(-1 AS SMALLINT) AS mis_weight_fg
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_net_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS val_discount_net_ejr
   ,CAST(-1 AS INTEGER)  AS discount_sid
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_orig_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_pos_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_hq_ejr
   ,CAST('1' AS CHAR(2)) AS return_reason_cd_ejr
   ,CAST(NULL AS TIMESTAMP) AS timestamp_begin_ejr
   ,CAST(NULL AS TIMESTAMP) AS timestamp_end_ejr
   ,CAST('' AS CHAR(2)) AS item_entry_method_cd_ejr
   ,CAST('' AS CHAR(2)) AS price_entry_method_cd_ejr
   ,CAST(NULL AS INTEGER) AS parent_line_nr_ejr
   ,CAST(NULL AS INTEGER) AS voided_by_line_nr_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_ejr
   ,CAST(NULL AS DECIMAL(9,4)) AS pct_vat_ejr
   ,CAST(0 AS DECIMAL(18,4)) AS cnt_payment_ejr
   ,CAST('11' AS CHAR(2)) tendertype_cd_ejr
   ,CAST('-1' AS VARCHAR(100)) AS original_orig_store_nr_ejr
   ,cntrt.dat_formdate AS original_dat_formdate_ejr
   ,CAST('' AS VARCHAR(100)) AS original_orig_receipt_nr_ejr
   ,CAST('' AS VARCHAR(100)) AS original_pos_terminal_id_ejr
   ,CAST('' AS VARCHAR(40)) AS authority_id
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 cntrt
   WHERE cntrt.transactiontype_id >= '400'
   -- The condition for the relevant stores is already applied at the source table.
   UNION ALL
   SELECT
    pinf.client_id
   ,CAST(1 AS INTEGER) AS  orig_receipt_serial_nr_ejr
   ,pinf.store_id
   ,pinf.pos_terminal_id
   ,pinf.dat_formdate
   ,pinf.time_receipt_ejr
   ,CAST('' AS VARCHAR(50)) AS barcode
   ,CAST (NULL AS INTEGER) AS  time_halfhour_id
   ,pinf.orig_receipt_nr_ejr
   ,pinf.timezone_cd
   ,pinf.dat_dayend
   ,pinf.checker_id
   ,pinf.transactiontype_id
   ,pinf.item_id AS item_id
   ,pinf.mainitemgroup_id AS mainitemgroup_id
   ,CAST(1 AS DECIMAL(18,4)) AS qty_piece_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_weight_ejr
   ,pinf.price_retail_ejr AS price_retail_ejr
   ,pinf.price_retail_ejr AS price_retail_adjstd_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr
   ,CAST('' AS CHAR(1)) AS price_type_ejr
   ,CAST(-1 AS SMALLINT) AS mis_weight_fg
   ,pinf.price_retail_ejr  AS val_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_net_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS val_discount_net_ejr
   ,CAST(-1 AS INTEGER)  AS discount_sid
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_orig_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_pos_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_hq_ejr
   ,CAST('1' AS CHAR(2)) AS return_reason_cd_ejr
   ,pinf.timestamp_begin_ejr AS timestamp_begin_ejr
   ,pinf.timestamp_end_ejr AS timestamp_end_ejr
   ,CAST('' AS CHAR(2)) AS item_entry_method_cd_ejr
   ,CAST('' AS CHAR(2)) AS price_entry_method_cd_ejr
   ,CAST(1 AS INTEGER) AS parent_line_nr_ejr
   ,CAST(NULL AS INTEGER) AS voided_by_line_nr_ejr
   ,CAST(NULL AS DECIMAL(18,4))  AS val_vat_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_ejr
   ,CAST(NULL AS DECIMAL(9,4)) AS pct_vat_ejr
   ,CAST(0 AS DECIMAL(18,4)) AS cnt_payment_ejr
   ,CAST('11' AS CHAR(2)) tendertype_cd_ejr
   ,CAST('-1' AS VARCHAR(100)) AS original_orig_store_nr_ejr
   ,pinf.dat_formdate AS original_dat_formdate_ejr
   ,CAST('' AS VARCHAR(100)) AS original_orig_receipt_nr_ejr
   ,CAST('' AS VARCHAR(100)) AS original_pos_terminal_id_ejr
   ,CAST('' AS VARCHAR(40)) AS authority_id
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_price_info_extract_2 pinf
   -- The condition for the relevant stores is already applied at the source table.
   UNION ALL
   SELECT
    paym.client_id
   ,paym.orig_receipt_serial_nr_ejr
   ,paym.store_id
   ,paym.pos_terminal_id
   ,paym.dat_formdate
   ,paym.time_receipt_ejr
   ,CAST('' AS VARCHAR(50)) AS barcode
   ,CAST (NULL AS INTEGER) AS  time_halfhour_id
   ,paym.orig_receipt_nr_ejr
   ,paym.timezone_cd
   ,paym.dat_dayend
   ,paym.checker_id
   ,paym.transactiontype_id
   ,CAST((-1000 - paym.client_id) AS INTEGER) AS item_id
   ,CAST(NULL AS INTEGER) AS mainitemgroup_id
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_piece_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_weight_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_adjstd_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr
   ,CAST('' AS CHAR(1)) AS price_type_ejr
   ,CAST(-1 AS SMALLINT) AS mis_weight_fg
   ,paym.val_retail_payment_ejr AS val_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_net_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS val_discount_net_ejr
   ,CAST(-1 AS INTEGER)  AS discount_sid
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_orig_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_pos_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_hq_ejr
   ,CAST('1' AS CHAR(2)) AS return_reason_cd_ejr
   ,CAST(NULL AS TIMESTAMP) AS timestamp_begin_ejr
   ,CAST(NULL AS TIMESTAMP) AS timestamp_end_ejr
   ,CAST('' AS CHAR(2)) AS item_entry_method_cd_ejr
   ,CAST('' AS CHAR(2)) AS price_entry_method_cd_ejr
   ,CAST(NULL AS INTEGER) AS parent_line_nr_ejr
   ,CAST(NULL AS INTEGER) AS voided_by_line_nr_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS  val_vat_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS  val_vat_ejr
   ,CAST(NULL AS DECIMAL(9,4)) AS  pct_vat_ejr
   ,CAST(paym.cnt_payment_ejr AS DECIMAL(18,4)) AS cnt_payment_ejr
   ,paym.tendertype_cd_ejr
   ,CAST('-1' AS VARCHAR(100)) AS original_orig_store_nr_ejr
   ,paym.dat_formdate AS original_dat_formdate_ejr
   ,CAST('' AS VARCHAR(100)) AS original_orig_receipt_nr_ejr
   ,CAST('' AS VARCHAR(100)) AS original_pos_terminal_id_ejr
   ,CAST('' AS VARCHAR(40)) AS authority_id
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_extract_2 paym
   -- The condition for the relevant stores is already applied at the source table.
   UNION ALL
   SELECT
    payntr.client_id
   ,payntr.orig_receipt_serial_nr_ejr
   ,payntr.store_id
   ,payntr.pos_terminal_id
   ,payntr.dat_formdate
   ,payntr.time_receipt_ejr
   ,CAST('' AS VARCHAR(50)) AS barcode
   ,CAST (NULL AS INTEGER) AS  time_halfhour_id
   ,payntr.orig_receipt_nr_ejr
   ,payntr.timezone_cd
   ,payntr.dat_dayend
   ,payntr.checker_id
   ,payntr.transactiontype_id
   ,CAST((-1000 - payntr.client_id) AS INTEGER) AS item_id
   ,CAST(NULL AS INTEGER) AS mainitemgroup_id
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_piece_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_weight_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS price_retail_adjstd_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS price_retail_net_adjstd_ejr
   ,CAST('' AS CHAR(1)) AS price_type_ejr
   ,CAST(-1 AS SMALLINT) AS mis_weight_fg
   ,payntr.val_retail_payment_ejr AS val_retail_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_net_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_ejr
   ,CAST(NULL AS DECIMAL(19,5)) AS val_discount_net_ejr
   ,CAST(-1 AS INTEGER)  AS discount_sid
   ,CAST(NULL AS DECIMAL(18,4)) AS val_retail_orig_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_discount_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_pos_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS qty_discount_hq_ejr
   ,CAST('1' AS CHAR(2)) AS return_reason_cd_ejr
   ,CAST(NULL AS TIMESTAMP) AS timestamp_begin_ejr
   ,CAST(NULL AS TIMESTAMP) AS timestamp_end_ejr
   ,CAST('' AS CHAR(2)) AS item_entry_method_cd_ejr
   ,CAST('' AS CHAR(2)) AS price_entry_method_cd_ejr
   ,CAST(NULL AS INTEGER) AS parent_line_nr_ejr
   ,CAST(NULL AS INTEGER) AS voided_by_line_nr_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_base_ejr
   ,CAST(NULL AS DECIMAL(18,4)) AS val_vat_ejr
   ,CAST(NULL AS DECIMAL(9,4)) AS pct_vat_ejr
   ,CAST(payntr.cnt_payment_ejr AS DECIMAL(18,4)) AS cnt_payment_ejr
   ,payntr.tendertype_cd_ejr
   ,CAST('-1' AS VARCHAR(100)) AS original_orig_store_nr_ejr
   ,payntr.dat_formdate AS original_dat_formdate_ejr
   ,CAST('' AS VARCHAR(100)) AS original_orig_receipt_nr_ejr
   ,CAST('' AS VARCHAR(100)) AS original_pos_terminal_id_ejr
   ,CAST('' AS VARCHAR(40)) AS authority_id
       FROM p_lew_mart_msi.v_mat0_zkp_etl_ejr_payment_ntr_extract_2 payntr
       -- The condition for the relevant stores is already applied at the source table.
   ) x
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_all_transact_follower_2 y
   ON y.store_id = x.store_id
   AND y.client_id = x.client_id
   AND y.pos_terminal_id = x.pos_terminal_id
   AND y.dat_formdate = x.dat_formdate
   AND y.time_receipt_ejr = x.time_receipt_ejr
   AND y.orig_receipt_nr_ejr = x.orig_receipt_nr_ejr
;
