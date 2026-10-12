CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_process_mstr_lil_fedstate_us_2_lil_fedstate_us_2 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
process_mstr_lil_fedstate_us_src_region_cd STRING(250) NOT NULL,
process_mstr_lil_fedstate_us_fedstate_cd STRING(250) NOT NULL,
process_mstr_lil_fedstate_us_valid_from DATE NOT NULL,
src_region_cd STRING(200) NOT NULL,
fedstate_cd STRING(20) NOT NULL,
valid_from DATE NOT NULL,
valid_to DATE NOT NULL,
active_fg BIGNUMERIC(38) NOT NULL,
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);