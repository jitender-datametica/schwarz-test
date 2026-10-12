CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_ean_hq_c_2 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38,0) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38,0),
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
item_nr_long STRING(14) COLLATE 'und:ci' NOT NULL,
orig_item_nr INTEGER NOT NULL,
case_size BIGNUMERIC(38,0) NOT NULL,
ean_2 STRING(13) COLLATE 'und:ci' NOT NULL,
ean_item_desc STRING(30) COLLATE 'und:ci',
custom_nr STRING(20) COLLATE 'und:ci',
custom_key STRING(10) COLLATE 'und:ci',
online_desc STRING(250) COLLATE 'und:ci',
dat_dayend DATE,
load_id BIGNUMERIC(38,0)
);