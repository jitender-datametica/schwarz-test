CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_familygroup_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_familygroup_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
subitemgroup_id BIGNUMERIC(38,0) NOT NULL,
family_cd BIGNUMERIC(38,0) NOT NULL,
item_family_desc STRING(150) COLLATE 'und:ci' NOT NULL,
item_family_short_desc STRING(35) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);