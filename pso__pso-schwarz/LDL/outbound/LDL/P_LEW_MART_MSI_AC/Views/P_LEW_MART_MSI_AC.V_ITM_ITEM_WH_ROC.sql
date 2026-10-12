/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_item_wh_roc (client_id, wh_id, item_id, dat_valid, stock_slot_fg,
stock_case_size_fg, qty_piece_five_weeks_fg, qty_piece_vs_case_size_fg, flags_combined, stock_slot_fg_vj,
stock_case_size_fg_vj, qty_piece_five_weeks_fg_vj, qty_piece_vs_case_size_fg_vj, flags_combined_vj, stock_slot_fg_vj_sw
, stock_case_size_fg_vj_sw, qty_piece_five_weeks_fg_vj_sw, qty_pce_vs_case_size_fg_vj_sw, flags_combined_vj_sw) AS
SELECT *
FROM ldl_p_lew_mart_msi.v_itm_item_wh_roc;