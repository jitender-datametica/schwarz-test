CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_core_lil_period_2_lil_period_2 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
core_lil_period_src_period_cd STRING(250) NOT NULL,
src_period_cd STRING(20) NOT NULL,
period_name STRING(100) COLLATE 'und:ci' NOT NULL,
period_type_id BIGNUMERIC(38) NOT NULL,
period_type_name STRING(100) COLLATE 'und:ci',
period_year BIGNUMERIC(38) NOT NULL,
src_period_cd_py STRING(40) NOT NULL,
src_period_cd_pq STRING(40) NOT NULL,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);