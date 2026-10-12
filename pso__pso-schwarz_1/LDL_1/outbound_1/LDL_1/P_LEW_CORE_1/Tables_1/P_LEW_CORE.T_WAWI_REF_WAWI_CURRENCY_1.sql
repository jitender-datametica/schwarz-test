CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_ref_wawi_currency_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
currency_nr BIGNUMERIC(38,0) NOT NULL,
dat_valid_from DATE,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
rate_currency_exchange NUMERIC(18,4),
currency_tolerance NUMERIC(18,4),
currency_sign1 STRING(5) COLLATE 'und:ci',
currency_sign2 STRING(5) COLLATE 'und:ci',
load_id BIGNUMERIC(38,0) NOT NULL
);