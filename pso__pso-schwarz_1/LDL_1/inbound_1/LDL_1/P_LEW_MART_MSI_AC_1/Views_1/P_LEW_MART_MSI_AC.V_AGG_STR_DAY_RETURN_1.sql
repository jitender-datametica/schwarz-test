CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_STR_DAY_RETURN_1
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, store_id
, loc_sid
, wh_id
, item_id
, subitemgroup_id
, booking_dat
, order_return_reason_cd
, return_qty
, return_val
, return_net_val
, currency_iso_cd
 )
AS
SELECT
client_id,
store_id,
loc_sid,
wh_id,
item_id,
subitemgroup_id,
booking_dat,
order_return_reason_cd,
return_qty,
return_val,
return_net_val,
currency_iso_cd
FROM p_lew_mart_msi.v_agg_str_day_return_1;





