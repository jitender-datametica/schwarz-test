CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_agg_store_avg_vat_values_ejr (
client_id BIGNUMERIC(38,0) NOT NULL,
st_loc_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
cy_month BIGNUMERIC(38,0) NOT NULL,
orig_store_nr BIGNUMERIC(38,0),
wh_loc_sid BIGNUMERIC(38,0),
val_rtl_gross_ejr NUMERIC(18,4),
val_rtl_net_ejr NUMERIC(19,5),
avg_pct_vat_store NUMERIC(19,6),
avg_pct_vat_store_previous_day NUMERIC(19,6),
avg_pct_vat_wh NUMERIC(19,6)
) CLUSTER BY dat_formdate;