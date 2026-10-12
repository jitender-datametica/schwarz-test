CREATE OR REPLACE TABLE ldl_p_lew_core.t_wawi_ref_client_currency_rate_2 (
client_id INTEGER NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
to_currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
rate_currency_exchange NUMERIC(29,4),
load_id INTEGER NOT NULL
);