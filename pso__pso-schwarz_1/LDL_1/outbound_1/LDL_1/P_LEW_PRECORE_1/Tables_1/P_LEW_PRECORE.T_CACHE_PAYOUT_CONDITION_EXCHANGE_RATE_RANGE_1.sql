CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_payout_condition_exchange_rate_range_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
supp_no_nat BIGNUMERIC(38,0),
item_no_nat BIGNUMERIC(38,0),
curr_iso_cd STRING(3),
exchange_rate_cond_start_dt DATE,
exchange_rate_cond_end_dt DATE,
min_exchange_rate BIGNUMERIC(38,5),
max_exchange_rate BIGNUMERIC(38,5),
payout_cond_net_val BIGNUMERIC(38,5),
extraction_dt DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);