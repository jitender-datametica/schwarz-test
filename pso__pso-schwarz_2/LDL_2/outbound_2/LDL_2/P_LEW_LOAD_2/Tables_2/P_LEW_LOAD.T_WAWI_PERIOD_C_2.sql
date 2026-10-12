CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_period_c_2 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(3) COLLATE 'und:ci',
factor_period BIGNUMERIC(38),
shelflife_desc STRING(15) COLLATE 'und:ci',
shelflife_short_desc STRING(20) COLLATE 'und:ci',
shelflife_id STRING(5) COLLATE 'und:ci' NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38) NOT NULL
);