CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ZKP_ETL_EJR_ITEM_RECEIPT_REL_2 as
   SELECT	
     tf.client_id,	
   tf.store_id,	
   tf.pos_terminal_id,	
   tf.time_receipt_ejr,	
   tf.dat_formdate,	
   tf.orig_receipt_nr_ejr,	
   tf.checker_id,	
   rl.item_id,	
   rl.barcode,	
   rl.barcode AS barcode_short,	
   'ITEM_VOID_GT_3' AS link_type,	
   Count(1) Over (PARTITION BY tf.client_id  ,tf.store_id  ,tf.checker_id  ,rl.item_id) AS cnt_item_void,	
   tf.val_retail_ejr	
   FROM p_lew_mart_msi.v_ejr_all_transact_follower_2 tf	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_receiptline_extract_2 rl	
   ON tf.client_id = rl.client_id	
   AND tf.store_id = rl.store_id	
   AND tf.pos_terminal_id = rl.pos_terminal_id	
   AND tf.time_receipt_ejr = rl.time_receipt_ejr	
   AND tf.dat_formdate = rl.dat_formdate	
   AND tf.orig_receipt_nr_ejr = rl.orig_receipt_nr_ejr	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_sys_revision_load_store_wrk_2 revstr	
   ON tf.store_id = revstr.store_id	
   AND tf.client_id = revstr.client_id	
   AND tf.dat_formdate BETWEEN revstr.dat_formdate_from   AND revstr.dat_formdate_until	
   INNER JOIN p_lew_mart_msi.v_mat0_zkp_etl_ejr_lp_threshold_manual_2 tm	
   ON tf.client_id = tm.client_id	
   AND Current_Date BETWEEN tm.dat_rec_start   AND tm.dat_rec_end	
   AND tm.approval_fg = 1	
 WHERE rl.voided_by_line_nr_ejr > 0	
 QUALIFY cnt_item_void > tm.mvoid_same_item_cnt	
;