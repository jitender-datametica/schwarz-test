CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_ITEM_WH_ROC_1
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, wh_id
, item_id
, dat_valid
, stock_slot_fg
, stock_case_size_fg
, qty_piece_five_weeks_fg
, qty_piece_vs_case_size_fg
, flags_combined
, stock_slot_fg_vj
, stock_case_size_fg_vj
, qty_piece_five_weeks_fg_vj
, qty_piece_vs_case_size_fg_vj
, flags_combined_vj
, stock_slot_fg_vj_sw
, stock_case_size_fg_vj_sw
, qty_piece_five_weeks_fg_vj_sw
, qty_pce_vs_case_size_fg_vj_sw
, flags_combined_vj_sw
 )
AS
SELECT
client_id,
wh_id,
item_id,
dat_valid,
stock_slot_fg,
stock_case_size_fg,
qty_piece_five_weeks_fg,
qty_piece_vs_case_size_fg,
flags_combined,
stock_slot_fg_vj,
stock_case_size_fg_vj,
qty_piece_five_weeks_fg_vj,
qty_piece_vs_case_size_fg_vj,
flags_combined_vj,
stock_slot_fg_vj_sw,
stock_case_size_fg_vj_sw,
qty_piece_five_weeks_fg_vj_sw,
qty_pce_vs_case_size_fg_vj_sw,
flags_combined_vj_sw
FROM p_lew_mart_msi.v_itm_item_wh_roc_1;


