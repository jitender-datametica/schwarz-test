CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_item_exduty_hq_c_1 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
item_nr_long STRING(18) COLLATE 'und:ci' NOT NULL,
orig_item_nr INTEGER NOT NULL,
case_size BIGNUMERIC(38) NOT NULL,
main_exduty BIGNUMERIC(38) NOT NULL,
sub_exduty BIGNUMERIC(38) NOT NULL,
pct_exc_duty NUMERIC(5,3),
dat_dayend DATE,
load_id BIGNUMERIC(38)
);