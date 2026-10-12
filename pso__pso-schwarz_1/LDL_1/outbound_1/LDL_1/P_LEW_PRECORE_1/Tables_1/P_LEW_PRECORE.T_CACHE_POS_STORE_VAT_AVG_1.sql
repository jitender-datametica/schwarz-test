CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_pos_store_vat_avg_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
loc_sid_wh BIGNUMERIC(38,0),
sales_val NUMERIC(18,5),
sales_net_val NUMERIC(18,5),
avg_pct_vat_store NUMERIC(18,5),
avg_pct_vat_store_prvs_shadow NUMERIC(18,5),
avg_pct_vat_wh NUMERIC(18,5),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);