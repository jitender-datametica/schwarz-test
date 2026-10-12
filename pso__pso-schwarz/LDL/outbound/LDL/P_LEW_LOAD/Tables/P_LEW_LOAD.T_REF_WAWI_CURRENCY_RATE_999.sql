CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ref_wawi_currency_rate_999 (
client_id BIGNUMERIC(38) NOT NULL,
currency_nr BIGNUMERIC(38) NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
unit_currency_exchange NUMERIC(9,2) NOT NULL,
rate_currency_exchange NUMERIC(18,4) NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);