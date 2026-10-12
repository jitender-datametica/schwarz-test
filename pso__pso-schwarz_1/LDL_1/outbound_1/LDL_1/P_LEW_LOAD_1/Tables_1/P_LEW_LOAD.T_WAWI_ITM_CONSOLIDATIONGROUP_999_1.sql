CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_itm_consolidationgroup_999_1 (
client_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Mandant_1'),
wh_loc_sid BIGNUMERIC(38) NOT NULL,
itm_consgrp_id BIGNUMERIC(38) NOT NULL,
dat_rec_start DATE NOT NULL,
dat_rec_end DATE NOT NULL,
itm_consgrp_desc STRING(50) COLLATE 'und:ci',
dat_modification DATE,
timestamp_fn DATETIME NOT NULL,
load_id BIGNUMERIC(38) NOT NULL
);