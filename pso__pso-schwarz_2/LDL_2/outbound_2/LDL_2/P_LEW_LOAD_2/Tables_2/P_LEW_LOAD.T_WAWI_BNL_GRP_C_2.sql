CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_bnl_grp_c_2 (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38),
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id STRING(3) COLLATE 'und:ci' NOT NULL,
statisticgroup_id BIGNUMERIC(38) NOT NULL,
statisticgroup_desc STRING(35) COLLATE 'und:ci' NOT NULL,
statisticgroup_position BIGNUMERIC(38) NOT NULL,
edit_fg BIGNUMERIC(38),
statisticgroup_desc_nat STRING(35) COLLATE 'und:ci' NOT NULL,
mainitemgroup_id BIGNUMERIC(38),
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
dat_dayend DATE,
load_id BIGNUMERIC(38)
);