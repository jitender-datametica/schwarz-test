CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_stc_change_item_wh_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_formdate DATE NOT NULL,
inv_id_stc_change BIGNUMERIC(38,0) NOT NULL,
stc_change_type_cd STRING(1) COLLATE 'und:ci' NOT NULL,
qty_piece_stc_change NUMERIC(18,4),
price_retail_stc_change NUMERIC(18,4) NOT NULL,
price_retail_net_stc_change NUMERIC(19,5),
load_id BIGNUMERIC(38,0) NOT NULL
) CLUSTER BY dat_formdate;