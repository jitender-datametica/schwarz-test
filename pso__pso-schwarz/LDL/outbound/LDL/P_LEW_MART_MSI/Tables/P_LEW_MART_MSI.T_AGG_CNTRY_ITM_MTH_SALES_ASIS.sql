CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_agg_cntry_itm_mth_sales_asis (
client_id BIGNUMERIC(38,0) NOT NULL,
orig_item_nr INTEGER NOT NULL,
dat_valid_from_item DATE,
cy_month BIGNUMERIC(38,0) NOT NULL,
qty_total NUMERIC(18,5),
cnt_store_week BIGNUMERIC(38,0),
avg_qty_sold_per_str_week NUMERIC(18,5),
val_rtl_ejr_asis NUMERIC(18,5),
val_rtl_net_ejr_asis NUMERIC(18,5),
val_rtl_str_days_w_sales_asis NUMERIC(18,5),
val_rtl_str_net_days_w_sales_asis NUMERIC(18,5),
item_turnover_ratio_eff NUMERIC(18,5),
item_turnover_ratio_net_eff NUMERIC(18,5)
) CLUSTER BY cy_month;