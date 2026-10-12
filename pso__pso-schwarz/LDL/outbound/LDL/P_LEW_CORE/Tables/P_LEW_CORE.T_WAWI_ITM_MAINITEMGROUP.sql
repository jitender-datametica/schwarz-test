CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_mainitemgroup (
client_id BIGNUMERIC(38,0) NOT NULL,
mainitemgroup_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
mainitemgroup_desc STRING(50) COLLATE 'und:ci' NOT NULL,
mainitemgroup_short_desc STRING(30) COLLATE 'und:ci',
mainitemgroup_sortterm BIGNUMERIC(38,0) NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);