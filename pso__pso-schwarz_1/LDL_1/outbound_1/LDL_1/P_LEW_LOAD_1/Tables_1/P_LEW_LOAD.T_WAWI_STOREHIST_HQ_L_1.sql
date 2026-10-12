CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_storehist_hq_l_1 (
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id INTEGER NOT NULL,
orig_store_nr INTEGER NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38)
);