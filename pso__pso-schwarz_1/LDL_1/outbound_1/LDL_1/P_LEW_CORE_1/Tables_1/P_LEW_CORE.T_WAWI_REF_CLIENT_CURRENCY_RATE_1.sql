CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_client_currency_rate_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
to_currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
rate_currency_exchange NUMERIC(18,4),
load_id BIGNUMERIC(38,0) NOT NULL
);