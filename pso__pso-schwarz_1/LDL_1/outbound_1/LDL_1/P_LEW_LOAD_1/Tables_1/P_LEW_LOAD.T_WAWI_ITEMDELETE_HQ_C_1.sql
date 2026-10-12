CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itemdelete_hq_c_1 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38),
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
item_nr_long STRING(24) COLLATE 'und:ci',
orig_item_nr INTEGER,
case_size BIGNUMERIC(38),
item_delete_desc STRING(35) COLLATE 'und:ci',
dat_item_delete DATE,
status_item_delete BIGNUMERIC(38),
item_closed_fg INTEGER,
dat_dayend DATE,
load_id BIGNUMERIC(38)
);