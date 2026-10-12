CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_SFO_EJR_DAY_JOIN
/*
#DescStart#
#$Revision: 8115 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , store_id
    , dat_calendar
    , currency_iso_cd
    , qty_total_sfo_asis
    , qty_t_sfo_wrtoff_zero_asis
    , val_rtl_rl_sfo_asis
    , val_rtl_rl_net_sfo_asis
    , val_wrtoff_zero_asis
    , val_wrtoff_zero_net_asis
    , val_retail_asis
    , val_retail_net_asis
    , cnt_customer_asis
    , val_retail_asis_py_sw
    , val_retail_net_asis_py_sw
    , cnt_customer_asis_py_sw
    , val_retail_asis_py_sd
    , val_retail_net_asis_py_sd
    , cnt_customer_asis_py_sd
    , val_retail_asis_adj
    , val_retail_net_asis_adj
    , cnt_customer_asis_adj
    , cnt_store_open_rev
)
AS
SELECT
client_id,
store_id,
dat_calendar,
currency_iso_cd,
qty_total_sfo_asis,
qty_t_sfo_wrtoff_zero_asis,
val_rtl_rl_sfo_asis,
val_rtl_rl_net_sfo_asis,
val_wrtoff_zero_asis,
val_wrtoff_zero_net_asis,
val_retail_asis,
val_retail_net_asis,
cnt_customer_asis,
val_retail_asis_py_sw,
val_retail_net_asis_py_sw,
cnt_customer_asis_py_sw,
val_retail_asis_py_sd,
val_retail_net_asis_py_sd,
cnt_customer_asis_py_sd,
val_retail_asis_adj,
val_retail_net_asis_adj,
cnt_customer_asis_adj,
cnt_store_open_rev
FROM p_lew_mart_msi.v_sfo_ejr_day_join
;


