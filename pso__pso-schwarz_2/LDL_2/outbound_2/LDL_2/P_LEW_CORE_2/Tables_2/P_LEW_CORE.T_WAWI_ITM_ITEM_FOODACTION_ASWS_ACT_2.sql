CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_item_foodaction_asws_act_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
buying_list_type_id BIGNUMERIC(38,0) NOT NULL,
buying_list_type_desc STRING(50) COLLATE 'und:ci',
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL,
dat_valid DATE NOT NULL
);