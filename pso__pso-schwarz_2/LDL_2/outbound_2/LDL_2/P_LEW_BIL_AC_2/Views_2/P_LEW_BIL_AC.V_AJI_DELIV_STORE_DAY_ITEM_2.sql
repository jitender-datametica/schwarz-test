CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_aji_deliv_store_day_item_2 (client_id, loc_sid_store, item_sid, dat_formdate,
cy_month, deliverytype_id, orig_store_nr, foodaction_fg, qty_total_del, val_rtl_rl_del, val_rtl_rl_net_del,
qty_piece_del, val_piece_del, val_piece_net_del, val_pr_diff_del, val_pr_diff_net_del) AS SELECT *
FROM ldl_p_lew_bil.v_aji_deliv_store_day_item_2;