CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_process_mstr_lil_tr_category_sig_2_lil_tr_category_sig_1 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
process_mstr_lil_tr_category_sig_src_subitemgrp_cd STRING(250) NOT NULL,
src_subitemgrp_cd STRING(40) NOT NULL,
active_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);