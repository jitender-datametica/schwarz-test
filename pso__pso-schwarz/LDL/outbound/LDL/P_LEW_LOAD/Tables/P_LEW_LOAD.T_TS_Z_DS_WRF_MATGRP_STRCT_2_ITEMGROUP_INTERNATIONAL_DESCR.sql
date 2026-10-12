CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_wrf_matgrp_strct_2_itemgroup_international_descr (
record_id INTEGER,
client_id BIGNUMERIC(38),
item_grp_int_sid BIGNUMERIC(38),
lang_sid BIGNUMERIC(38),
lang_cd STRING(20),
item_grp_int_descr STRING(100) COLLATE 'und:ci',
item_grp_int_descr_long STRING(100) COLLATE 'und:ci',
item_grp_int_descr_caps STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);