CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_PRICE_BUYING_DAY_2
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, item_id
, dat_calendar
, wh_id
, supplier_id
, price_buying
, price_buying_sp_cond
, orig_item_nr
, currency_iso_cd
 )
AS
SELECT
client_id,
item_id,
dat_calendar,
wh_id,
supplier_id,
price_buying,
price_buying_sp_cond,
orig_item_nr,
currency_iso_cd
FROM p_lew_mart_msi.v_itm_price_buying_day_2;


