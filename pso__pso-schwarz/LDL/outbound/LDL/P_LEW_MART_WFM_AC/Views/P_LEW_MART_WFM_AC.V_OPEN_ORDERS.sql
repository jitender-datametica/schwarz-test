CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_open_orders (client_id, country_cd, src_wh_id, src_orig_item_nr,
dat_delivery, remaining_case, complete_case, remaining_ep, complete_ep, remainig_piece, complete_piece) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_open_orders;