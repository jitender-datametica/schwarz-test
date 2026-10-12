CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_currency_hq_l (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
currency_nr INTEGER NOT NULL,
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
currency_desc STRING(28) COLLATE 'und:ci' NOT NULL,
dat_valid_from DATE,
rate_currency_exchange INTEGER,
currency_tolerance NUMERIC(18,4),
currency_sign1 STRING(3) COLLATE 'und:ci',
currency_sign2 STRING(3) COLLATE 'und:ci',
dat_dayend DATE,
load_id BIGNUMERIC(38) NOT NULL
);