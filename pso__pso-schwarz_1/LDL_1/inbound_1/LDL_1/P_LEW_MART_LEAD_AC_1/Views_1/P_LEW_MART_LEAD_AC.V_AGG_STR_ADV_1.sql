CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STR_ADV_1

(
  client_id
, loc_sid_store_move_to
, loc_sid_wh
, wh_id
, flg_itm_grp
, dat_adv
, qty_sales_1_day
, qty_sales_3_day
, qty_sales_7_day
, qty_stc_real_1_day
, qty_delivery_1_day
, qty_stc_real_3_day
, qty_delivery_3_day
, qty_stc_real_7_day
, qty_delivery_7_day
, timestamp_mod
)
AS

/*
#DescStart#
#$Revision: 14656 $, $LastChangedBy: mmalinowski $
#SubjectAreas#: Access Layer
#DescEnd#
*/
SELECT
client_id,
loc_sid_store_move_to,
loc_sid_wh,
wh_id,
flg_itm_grp,
dat_adv,
qty_sales_1_day,
qty_sales_3_day,
qty_sales_7_day,
qty_stc_real_1_day,
qty_delivery_1_day,
qty_stc_real_3_day,
qty_delivery_3_day,
qty_stc_real_7_day,
qty_delivery_7_day,
timestamp_mod
FROM p_lew_mart_lead.v_agg_str_adv_1
;


