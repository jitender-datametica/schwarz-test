CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_process_mstr_lil_period_2_lil_period_1 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
process_mstr_lil_period_src_period_cd STRING(250) NOT NULL,
src_period_cd STRING(40) NOT NULL,
period_id BIGNUMERIC(38) NOT NULL,
period_lvl BIGNUMERIC(38) NOT NULL,
liam_avbl_fg BIGNUMERIC(38),
lift_avbl_fg BIGNUMERIC(38),
active_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);