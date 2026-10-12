CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_INV_ITEM_WH_2
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
, dat_dayend
, dat_formdate
, inv_id
, inv_type
, inv_desc
, byr
, inv_eval_fg
, store_place
, aisle_desc
, slot_nr
, diff_qty_inv_wh
, price_retail_inv_wh
, price_retail_net_inv_wh
, qty_case_inv_wh
, qty_piece_inv_wh
, qty_expected_inv_wh
, qty_total_inv_wh
, qty_ramp_inv_wh
, case_size_dec
, store_id
, currency_iso_cd
 )
AS
SELECT
client_id,
wh_id,
item_id,
dat_dayend,
dat_formdate,
inv_id,
inv_type,
inv_desc,
byr,
inv_eval_fg,
store_place,
aisle_desc,
slot_nr,
diff_qty_inv_wh,
price_retail_inv_wh,
price_retail_net_inv_wh,
qty_case_inv_wh,
qty_piece_inv_wh,
qty_expected_inv_wh,
qty_total_inv_wh,
qty_ramp_inv_wh,
case_size_dec,
store_id,
currency_iso_cd
FROM p_lew_mart_msi.v_inv_item_wh_2;





