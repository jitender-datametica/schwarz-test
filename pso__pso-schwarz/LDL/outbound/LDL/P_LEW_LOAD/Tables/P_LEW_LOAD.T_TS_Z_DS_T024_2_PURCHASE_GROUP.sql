CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_z_ds_t024_2_purchase_group (
record_id INTEGER,
client_id BIGNUMERIC(38),
pur_grp_sid BIGNUMERIC(38),
src_ekgrp STRING(20),
pur_grp_name STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);