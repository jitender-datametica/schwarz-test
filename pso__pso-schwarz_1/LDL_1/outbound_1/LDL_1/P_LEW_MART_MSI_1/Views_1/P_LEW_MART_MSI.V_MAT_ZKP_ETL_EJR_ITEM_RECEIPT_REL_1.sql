CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_zkp_etl_ejr_item_receipt_rel_1 AS SELECT TF.client_id,
 TF.store_id,
 TF.pos_terminal_id,
 TF.time_receipt_ejr,
 TF.dat_formdate,
 TF.orig_receipt_nr_ejr,
 TF.checker_id,
 RL.item_id,
 RL.barcode,
 RL.barcode AS barcode_short,
 'ITEM_VOID_GT_3' AS link_type,
 COUNT(1) OVER (PARTITION BY TF.client_id, TF.store_id, TF.checker_id, RL.item_id RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS cnt_item_void,
 TF.val_retail_ejr
FROM ldl_p_lew_mart_msi.v_ejr_all_transact_follower_1 AS TF
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_1 AS RL ON TF.client_id = RL.client_id AND TF.store_id
        = RL.store_id AND TF.pos_terminal_id = RL.pos_terminal_id AND TF.time_receipt_ejr = RL.time_receipt_ejr AND TF.dat_formdate
     = RL.dat_formdate AND TF.orig_receipt_nr_ejr = RL.orig_receipt_nr_ejr
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_1 AS REVSTR ON TF.store_id = REVSTR.store_id AND
    TF.client_id = REVSTR.client_id AND TF.dat_formdate BETWEEN REVSTR.dat_formdate_from AND REVSTR.dat_formdate_until
 INNER JOIN ldl_p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_threshold_manual_1 AS TM ON TF.client_id = TM.client_id AND
    CURRENT_DATE BETWEEN TM.dat_rec_start AND TM.dat_rec_end AND TM.approval_fg = 1
WHERE RL.voided_by_line_nr_ejr > 0
QUALIFY (COUNT(1) OVER (PARTITION BY TF.client_id, TF.store_id, TF.checker_id, RL.item_id RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > TM.mvoid_same_item_cnt;