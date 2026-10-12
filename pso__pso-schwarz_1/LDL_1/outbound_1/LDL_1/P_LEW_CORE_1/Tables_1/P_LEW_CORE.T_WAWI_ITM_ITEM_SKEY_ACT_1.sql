CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_item_skey_act_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
orig_item_nr INTEGER NOT NULL,
case_size BIGNUMERIC(38,0) NOT NULL,
reused_nr BIGNUMERIC(38,0),
dat_deleted DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL,
deleted_rmi_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
);