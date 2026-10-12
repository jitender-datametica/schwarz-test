CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_process_mstr_lil_retailer_group_change_2_lil_retailer_group_change (
retailer_group_change_id BIGNUMERIC(38) NOT NULL,
src_retailer_grp_cd STRING(100),
src_retailer_chld_cd STRING(100),
src_retailer_chg_cd STRING(100),
active_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);