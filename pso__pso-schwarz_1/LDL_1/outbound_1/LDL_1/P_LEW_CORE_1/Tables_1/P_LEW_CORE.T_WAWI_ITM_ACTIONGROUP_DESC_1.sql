CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_actiongroup_desc_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sub_actiongroup_id BIGNUMERIC(38,0) NOT NULL,
item_actiongroup_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
dat_valid_from DATE NOT NULL,
dat_valid_until DATE NOT NULL,
item_sub_actgroup_desc STRING(50) COLLATE 'und:ci' NOT NULL,
item_actgroup_desc STRING(50) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0)
);