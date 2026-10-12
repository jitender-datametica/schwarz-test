CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itemfam_hq_c (
err_id INTEGER NOT NULL,
err_release BIGNUMERIC(38) DEFAULT 0,
release_user STRING(30) COLLATE 'und:ci',
err_date DATE DEFAULT CURRENT_DATE NOT NULL,
err_cd BIGNUMERIC(38),
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id_hq STRING(3) COLLATE 'und:ci' NOT NULL,
item_familygroup_id BIGNUMERIC(38) NOT NULL,
subitemgroup_id BIGNUMERIC(38) NOT NULL,
mainitemgroup_id BIGNUMERIC(38) NOT NULL,
family_cd BIGNUMERIC(38) NOT NULL,
item_family_desc STRING(120) COLLATE 'und:ci' NOT NULL,
item_family_short_desc STRING(15) COLLATE 'und:ci',
dat_dayend DATE,
load_id BIGNUMERIC(38)
);