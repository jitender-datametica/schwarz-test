CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_item_int_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
orig_item_nr_int INTEGER NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
case_size_int BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0) NOT NULL,
item_desc_int STRING(100) COLLATE 'und:ci',
active_int_fg BIGNUMERIC(38,0),
load_id BIGNUMERIC(38,0) NOT NULL
);