CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_ejr_return_price_2 (client_id, store_id, pos_terminal_id, dat_formdate,
time_receipt_ejr, orig_receipt_nr_ejr, checker_id, s_client_id_ejr, s_orig_store_nr_ejr, s_dat_formdate_ejr,
s_orig_receipt_nr_ejr, s_pos_terminal_id_ejr, item_id, rt_price_retail_ejr, s_price_retail_ejr, max_wawi_price,
is_return_price_gt_sale, is_return_price_gt_wawi) AS SELECT *
FROM ldl_p_lew_mart_msi.v_ejr_return_price_2;