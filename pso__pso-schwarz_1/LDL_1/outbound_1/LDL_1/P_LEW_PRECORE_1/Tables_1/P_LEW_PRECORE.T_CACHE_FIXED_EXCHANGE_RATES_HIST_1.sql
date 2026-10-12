CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_fixed_exchange_rates_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
bic_zmlila STRING(20),
currency_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
to_currency_iso_cd STRING(20) COLLATE 'und:ci' NOT NULL,
valid_from_dat DATE NOT NULL,
valid_to_dat DATE NOT NULL,
rate_currency_exchange NUMERIC(18,5),
deleted_fg BIGNUMERIC(38,0),
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, valid_from_dat, dwh_valid_from) NOT ENFORCED
);