CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_currency_hq_c_2 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38) NOT NULL,
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