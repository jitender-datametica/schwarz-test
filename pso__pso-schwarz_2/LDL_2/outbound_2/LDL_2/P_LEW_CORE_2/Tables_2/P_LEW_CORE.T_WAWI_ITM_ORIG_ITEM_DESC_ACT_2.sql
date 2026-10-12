CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_orig_item_desc_act_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
orig_item_nr INTEGER NOT NULL,
dat_valid_from DATE,
item_desc STRING(50) COLLATE 'und:ci',
language_id BIGNUMERIC(38,0) NOT NULL
);