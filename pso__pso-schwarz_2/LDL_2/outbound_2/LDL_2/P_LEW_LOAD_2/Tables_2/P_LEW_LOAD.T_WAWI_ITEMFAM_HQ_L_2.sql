CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itemfam_hq_l_2 (
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