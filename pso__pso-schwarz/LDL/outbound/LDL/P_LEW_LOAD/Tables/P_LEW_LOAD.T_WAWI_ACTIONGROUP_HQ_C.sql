CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_actiongroup_hq_c (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38) NOT NULL,
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
item_sub_actgroup_desc_country STRING(50) COLLATE 'und:ci',
item_sub_actgroup_desc_german STRING(50) COLLATE 'und:ci' NOT NULL,
item_sub_actiongroup_id BIGNUMERIC(38) NOT NULL,
item_actgroup_desc_country STRING(50) COLLATE 'und:ci',
item_actgroup_desc_german STRING(50) COLLATE 'und:ci' NOT NULL,
item_actiongroup_id BIGNUMERIC(38) NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38)
);