CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_currency_hq_999_1 (
client_id BIGNUMERIC(38) NOT NULL,
currency_nr BIGNUMERIC(38),
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
currency_desc STRING(50) COLLATE 'und:ci',
dat_valid_from DATE,
rate_currency_exchange NUMERIC(18,4),
currency_tolerance FLOAT64,
currency_sign1 STRING(5) COLLATE 'und:ci',
currency_sign2 STRING(5) COLLATE 'und:ci',
dat_dayend DATE,
load_id BIGNUMERIC(38) NOT NULL
);