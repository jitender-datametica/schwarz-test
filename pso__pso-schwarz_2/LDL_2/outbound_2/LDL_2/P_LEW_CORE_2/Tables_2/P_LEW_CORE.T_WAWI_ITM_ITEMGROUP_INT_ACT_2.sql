CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_itemgroup_int_act_2 (
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL,
itemgroup_int_remark STRING(60) COLLATE 'und:ci',
itemgroup_int_desc STRING(50) COLLATE 'und:ci' NOT NULL,
language_id BIGNUMERIC(38,0) NOT NULL
);