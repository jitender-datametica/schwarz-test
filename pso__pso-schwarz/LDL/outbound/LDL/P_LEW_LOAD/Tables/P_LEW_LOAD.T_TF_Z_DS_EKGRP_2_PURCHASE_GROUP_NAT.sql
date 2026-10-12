CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_ekgrp_2_purchase_group_nat (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_ekgrp_zmekgrpnm STRING(6),
src_ekgrp STRING(20),
pur_grp_nat_name STRING(100) COLLATE 'und:ci',
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);