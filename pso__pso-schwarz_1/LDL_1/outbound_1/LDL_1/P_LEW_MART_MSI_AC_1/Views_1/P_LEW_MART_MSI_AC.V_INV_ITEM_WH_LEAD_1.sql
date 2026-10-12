/* #DescStart#
#$Revision: 6699 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_inv_item_wh_lead_1 (client_id, wh_id, item_id, dat_dayend, dat_formdate,
inv_id, inv_type, inv_desc, byr, inv_eval_fg, store_place, aisle_desc, slot_nr, diff_qty_inv_wh, price_retail_inv_wh,
price_retail_net_inv_wh, diff_inv_wh_val, diff_inv_wh_net_val, qty_case_inv_wh, qty_piece_inv_wh, qty_expected_inv_wh,
qty_total_inv_wh, qty_ramp_inv_wh, case_size_dec, currency_iso_cd) AS SELECT *
FROM ldl_p_lew_mart_msi.v_inv_item_wh_lead_1;