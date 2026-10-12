CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_subitemgroup_desc_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
subitemgroup_id BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
subitemgroup_desc STRING(50) COLLATE 'und:ci',
subitemgroup_short_desc STRING(30) COLLATE 'und:ci',
subitemgroup_sortterm BIGNUMERIC(38,0),
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);