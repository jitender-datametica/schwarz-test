CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_curr_rate_hq_c_2 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
currency_nr INTEGER NOT NULL,
dat_valid_from DATE NOT NULL,
unit_currency_exchange NUMERIC(6,2) NOT NULL,
rate_currency_exchange NUMERIC(18,4),
file_name STRING(100) COLLATE 'und:ci' NOT NULL,
timestamp_fn DATETIME NOT NULL,
dat_dayend DATE NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);