CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_store_day_item_adv_asis_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
wh_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_store_move_to BIGNUMERIC(38,0) NOT NULL,
src_itemgrp_int_cd BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0) NOT NULL,
dat_adv DATE NOT NULL,
dat_formdate DATE NOT NULL,
qty_sales NUMERIC(18,4),
qty_delivery NUMERIC(18,4),
qty_stc_real NUMERIC(18,4),
timestamp_mod DATETIME
) CLUSTER BY client_id, dat_adv;