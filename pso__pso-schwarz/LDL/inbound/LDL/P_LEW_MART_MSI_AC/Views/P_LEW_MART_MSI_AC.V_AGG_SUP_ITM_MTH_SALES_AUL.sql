CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_SUP_ITM_MTH_SALES_AUL
/*
#DescStart#
#$Revision: 6699 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, country_iso_cd
, cy_month
, item_id
, orig_item_nr
, dat_valid_from_item
, case_size
, qty_total
, val_rtl_ejr_asis
, val_rtl_net_ejr_asis
, val_rtl_str_days_w_sales_asis
, val_rtl_str_net_days_w_s_asis
, avg_qty_sold_per_str_week
, wh_id
, supplier_id
, orig_supplier_nr
, currency_iso_cd
, qty_total_rcv
 )
AS
SELECT
client_id,
country_iso_cd,
cy_month,
item_id,
orig_item_nr,
dat_valid_from_item,
case_size,
qty_total,
val_rtl_ejr_asis,
val_rtl_net_ejr_asis,
val_rtl_str_days_w_sales_asis,
val_rtl_str_net_days_w_s_asis,
avg_qty_sold_per_str_week,
wh_id,
supplier_id,
orig_supplier_nr,
currency_iso_cd,
qty_total_rcv
FROM p_lew_mart_msi.v_agg_sup_itm_mth_sales_aul;


