/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_REL_LIDLPLUS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2023    Szewczyk,Milosz          AP0188368: ZKP new scenario Lidl Plus
#  1.1  20.09.2024    Szewczyk,Milosz          AP676219: Fix to disable countries without set thresholds for LidlPlus
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_rel_lidlplus_1 (client_id, store_id, pos_terminal_id,
time_receipt_ejr, dat_formdate, orig_receipt_nr_ejr, wh_id, checker_id, lidlplus_customer_cd, lidlplus_ident_type_cd,
val_retail_ejr) AS -- CROSS JOIN to *load_store to get only the relevant stores
 SELECT t1.client_id,
 t1.store_id,
 t1.pos_terminal_id,
 t1.time_receipt_ejr,
 t1.dat_formdate,
 t1.orig_receipt_nr_ejr,
 MAX(REVSTR.wh_id) AS wh_id,
 MAX(t1.checker_id) AS checker_id,
 MAX(t1.lidlplus_customer_cd) AS lidlplus_customer_cd,
 MAX(t1.lidlplus_ident_type_cd) AS lidlplus_ident_type_cd,
 MAX(t1.val_retail_ejr) AS val_retail_ejr
FROM (SELECT client_id,
   store_id,
   header_collection,
   pos_terminal_id,
   time_receipt_ejr,
   time_halfhour_id,
   receipt_for_count_id,
   orig_receipt_nr_ejr,
   orig_receipt_serial_nr_ejr,
   timezone_cd,
   dat_dayend,
   dat_formdate,
   checker_id,
   transactiontype_id,
   cnt_receiptline_ejr,
   cnt_selling_position_ejr,
   cnt_discount_ejr,
   cnt_deposit_ejr,
   cnt_return_ejr,
   cnt_void_ejr,
   cnt_ean_ejr,
   cnt_item_ejr,
   cnt_item_weight_ejr,
   cnt_mainitemgroup_ejr,
   qty_piece_ejr,
   val_retail_ejr,
   val_retail_net_ejr,
   val_retail_pos_ejr,
   val_retail_net_pos_ejr,
   val_deposit_ejr,
   val_deposit_net_ejr,
   val_discount_ejr,
   val_discount_net_ejr,
   resumed_trans_store_id_ejr,
   resumed_trans_terminal_id_ejr,
   resumed_trans_date_ejr,
   resumed_trans_receipt_nr_ejr,
   dur_service_time_ejr,
   dur_pay_change_time_ejr,
   timestamp_begin_ejr,
   timestamp_end_ejr,
   currency_iso_cd,
   customer_nr,
   lidlplus_customer_cd,
   lidlplus_ident_type_cd,
   RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(store_id AS STRING), CAST(checker_id AS STRING),
      dat_formdate, CAST(orig_receipt_nr_ejr AS STRING) ORDER BY timestamp_begin_ejr IS NULL, timestamp_begin_ejr,
      orig_receipt_serial_nr_ejr IS NULL, orig_receipt_serial_nr_ejr) AS rank_by_timestamp
  FROM ldl_p_lew_mart_msi.v_ejr_receiptheader_1) AS t1_1
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON t1.store_id = REVSTR.store_id AND
    t1.client_id = REVSTR.client_id AND t1.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
   -- CROSS JOIN to thresholds table to remove countries without any thresholds set

 INNER JOIN ldl_p_lew_mart_msi.v_ejr_lp_threshold_receipt_1 AS TR ON t1.client_id = TR.client_id AND TR.plus_rec_month
   IS NOT NULL AND TR.plus_rec_day IS NOT NULL
WHERE t1.lidlplus_customer_cd IS NOT NULL
GROUP BY t1.client_id,
 t1.store_id,
 t1.pos_terminal_id,
 t1.time_receipt_ejr,
 t1.dat_formdate,
 t1.orig_receipt_nr_ejr;