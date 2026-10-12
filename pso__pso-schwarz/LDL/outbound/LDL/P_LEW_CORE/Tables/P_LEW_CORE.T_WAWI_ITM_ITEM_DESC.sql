CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_item_desc (
client_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
item_desc STRING(100) COLLATE 'und:ci',
orig_item_nr INTEGER,
language_id BIGNUMERIC(38,0) NOT NULL,
load_id BIGNUMERIC(38,0) NOT NULL
);