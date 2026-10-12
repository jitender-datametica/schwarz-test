CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_agg_str_day_ejr_txj_ww_ext (
client_id BIGNUMERIC(38,0) NOT NULL,
store_id BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
cy_month BIGNUMERIC(38,0) NOT NULL,
currency_iso_cd STRING(20),
val_retail_asis NUMERIC(18,5),
val_retail_net_asis BIGNUMERIC(38,5),
cnt_customer_asis NUMERIC(18,4),
val_retail_extrapol_asis BIGNUMERIC(38,5),
val_retail_net_extrapol_asis BIGNUMERIC(38,5)
) CLUSTER BY dat_formdate, client_id;