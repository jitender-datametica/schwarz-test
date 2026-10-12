CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_core_lil_region_2_lil_region (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
core_lil_region_src_region_cd STRING(250) NOT NULL,
src_region_cd STRING(100) NOT NULL,
region_name STRING(100) COLLATE 'und:ci' NOT NULL,
country_cd STRING(40) NOT NULL,
country_pol_cd STRING(40),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);