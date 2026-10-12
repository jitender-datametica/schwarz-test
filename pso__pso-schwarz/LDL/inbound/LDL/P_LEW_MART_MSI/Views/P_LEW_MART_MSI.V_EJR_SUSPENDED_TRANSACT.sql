CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_SUSPENDED_TRANSACT as
      SELECT	
        t.resumed_trans_store_id_ejr,	
      t.resumed_trans_terminal_id_ejr,	
      t.resumed_trans_date_ejr,	
      t.resumed_trans_receipt_nr_ejr,	
      Max(t.resumed_trans_seqnr) AS resumed_trans_seqnr,	
      t.st_loc_sid  AS  store_id,	
      t.client_id,	
      t.pos_terminal_id,	
      t.dat_formdate,	
      t.orig_receipt_nr_ejr,	
      t.checker_id,	
      t.time_receipt_ejr,	
      t.transactiontype_id,	
      t.val_susp_retail_ejr,	
      t.susp_next_transactiontype_id,	
      t.val_susp_next_retail_ejr,	
      t.cnt_s_all_salelines,	
      t.cnt_s_all_voidedlines_in_res,	
      t.is_s_lastline_sale,	
      t.cnt_s_voidedlines_beforlast,	
      t.cnt_s_all_lines,	
      t.cnt_r_all_salelines,	
      t.cnt_r_all_voidedlines_in_res,	
      t.is_r_lastline_sale,	
      t.cnt_r_voidedlines_beforlast,	
      t.cnt_r_all_lines,	
      t.val_r_voided,	
      t.val_s_voided,	
      t.is_voided_till_last_artikel,	
      t.is_new_item_in_resume,	
      t.is_suspend_gt_10,	
      t.is_next_tran_cond,	
      t.is_resumed_aborted,	
      Max(t.checker_id) Over (PARTITION BY t.resumed_trans_store_id_ejr , t.resumed_trans_terminal_id_ejr, t.resumed_trans_date_ejr, t.resumed_trans_receipt_nr_ejr) AS max_checker_id,	
      Min(t.checker_id) Over (PARTITION BY t.resumed_trans_store_id_ejr , t.resumed_trans_terminal_id_ejr, t.resumed_trans_date_ejr, t.resumed_trans_receipt_nr_ejr) AS min_checker_id,	
      CASE WHEN max_checker_id = min_checker_id THEN 1 ELSE 0 END AS same_checker_fg,	
      t.is_voided_till_last_artikel_mc,	
      t.is_new_item_in_resume_mc,	
      t.is_open_suspended,	
      t.is_next_low_tran,	
      t.is_next_low_tran_mc,	
      t.is_next_abmeld_mc	
     FROM p_lew_mart_msi.t_msi_ejr_suspended_transact t	
      GROUP BY	
        t.resumed_trans_store_id_ejr	
      , t.resumed_trans_terminal_id_ejr	
      , t.resumed_trans_date_ejr	
      , t.resumed_trans_receipt_nr_ejr	
      , t.st_loc_sid	
      , t.client_id	
      , t.pos_terminal_id	
      , t.dat_formdate	
      , t.orig_receipt_nr_ejr	
      , t.checker_id	
      , t.time_receipt_ejr	
      , t.transactiontype_id	
      , t.val_susp_retail_ejr	
      , t.susp_next_transactiontype_id	
      , t.val_susp_next_retail_ejr	
      , t.cnt_s_all_salelines	
      , t.cnt_s_all_voidedlines_in_res	
      , t.is_s_lastline_sale	
      , t.cnt_s_voidedlines_beforlast	
      , t.cnt_s_all_lines	
      , t.cnt_r_all_salelines	
      , t.cnt_r_all_voidedlines_in_res	
      , t.is_r_lastline_sale	
      , t.cnt_r_voidedlines_beforlast	
      , t.cnt_r_all_lines	
      , t.val_r_voided	
      , t.val_s_voided	
      , t.is_voided_till_last_artikel	
      , t.is_new_item_in_resume	
      , t.is_suspend_gt_10	
      , t.is_next_tran_cond	
      , t.is_resumed_aborted	
      , t.is_voided_till_last_artikel_mc	
      , t.is_new_item_in_resume_mc	
      , t.is_open_suspended	
      , t.is_next_low_tran	
      , t.is_next_low_tran_mc	
      , t.is_next_abmeld_mc	
;