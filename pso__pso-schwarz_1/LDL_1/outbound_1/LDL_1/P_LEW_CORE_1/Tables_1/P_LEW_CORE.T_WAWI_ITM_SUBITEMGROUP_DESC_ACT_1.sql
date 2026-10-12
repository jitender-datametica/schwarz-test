CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_subitemgroup_desc_act_1 (
subitemgroup_id BIGNUMERIC(38,0) NOT NULL,
subitemgroup_desc STRING(50) COLLATE 'und:ci',
subitemgroup_short_desc STRING(30) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL,
subitemgroup_sortterm BIGNUMERIC(38,0)
);