CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_BO_INV_DIFF_WAWI_1
/*
#DescStart#
#$Revision: 7891 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , country_desc
    , country_id
    , country_iso_cd
    , store_id
    , orig_store_nr
    , store_desc
    , city
    , wh_id
    , wh_desc
    , sales_manager_id
    , sales_manager_name
    , account_manager_id
    , account_manager_name
    , inv_id
    , cy_month
    , busyear
    , dat_formdate
    , dat_valid_from
    , dat_valid_until
    , currency_iso_cd
    , day_cnt
    , diff_inv
    , diff_net_inv
    , avg_diff_per_day
    , val_retail
    , val_retail_net
    , val_retail_cum_byr
    , val_retail_net_cum_byr
    , inv_diff_to_val_rtl_pct
    , inv_diff_to_val_rtl_net_pct
    , diff_busyear_cum
    , diff_net_busyear_cum
    , avg_diff_per_day_cum
    , inv_diff_pct_cum
    , inv_diff_net_pct_cum
    , inv_diff_pct_cum_py
    , inv_diff_net_pct_cum_py
    , day_cnt_cum_byr
    , diff_inv_diff_pct_cum_act_py
    , diff_inv_diff_net_pct_cum_py
    , top20_inv_diff_to_val_rtl_pct
    , top20_inv_dif_val_rtl_net_pct
)
AS
SELECT
client_id,
country_desc,
country_id,
country_iso_cd,
store_id,
orig_store_nr,
store_desc,
city,
wh_id,
wh_desc,
sales_manager_id,
sales_manager_name,
account_manager_id,
account_manager_name,
inv_id,
cy_month,
busyear,
dat_formdate,
dat_valid_from,
dat_valid_until,
currency_iso_cd,
day_cnt,
diff_inv,
diff_net_inv,
avg_diff_per_day,
val_retail,
val_retail_net,
val_retail_cum_byr,
val_retail_net_cum_byr,
inv_diff_to_val_rtl_pct,
inv_diff_to_val_rtl_net_pct,
diff_busyear_cum,
diff_net_busyear_cum,
avg_diff_per_day_cum,
inv_diff_pct_cum,
inv_diff_net_pct_cum,
inv_diff_pct_cum_py,
inv_diff_net_pct_cum_py,
day_cnt_cum_byr,
diff_inv_diff_pct_cum_act_py,
diff_inv_diff_net_pct_cum_py,
top20_inv_diff_to_val_rtl_pct,
top20_inv_dif_val_rtl_net_pct
FROM p_lew_mart_msi.v_bo_inv_diff_wawi_1
;


