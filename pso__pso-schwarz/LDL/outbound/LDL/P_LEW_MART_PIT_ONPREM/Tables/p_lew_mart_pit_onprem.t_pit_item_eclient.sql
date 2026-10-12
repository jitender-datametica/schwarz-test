CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_item_eclient (
effective_client_id BIGNUMERIC(38,0) DEFAULT - 1,
item_sid BIGNUMERIC(38,0) DEFAULT - 1,
client_id BIGNUMERIC(38,0) DEFAULT - 1,
luxembourg_fg BIGNUMERIC(38,0) DEFAULT 0,
lang_sid BIGNUMERIC(38,0) DEFAULT - 1,
item_mstr_sid BIGNUMERIC(38,0) DEFAULT - 1,
orig_item_nr INTEGER,
case_size BIGNUMERIC(38,5),
dat_valid_from DATE DEFAULT DATE '8888-12-31',
item_name STRING(16777216),
item_description STRING(16777216)
);