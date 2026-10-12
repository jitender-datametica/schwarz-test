CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itm_item_consolidation_999 (
client_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Mandant'),
wh_loc_sid BIGNUMERIC(38) NOT NULL,
item_sid BIGNUMERIC(38) NOT NULL,
itm_consgrp_id BIGNUMERIC(38) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
dat_modification DATE,
timestamp_fn DATETIME NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);