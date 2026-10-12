CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_core_lil_period_per_region_2_lil_period_per_region_2 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
core_lil_period_per_region_src_region_cd STRING(250) NOT NULL,
core_lil_period_per_region_src_period_cd STRING(250) NOT NULL,
src_period_cd STRING(40) NOT NULL,
src_region_cd STRING(40) NOT NULL,
start_dt DATE,
end_dt DATE,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);