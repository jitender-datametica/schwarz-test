CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_t005_2_country_political_2 (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_t005_land1 STRING(6),
src_land1 STRING(20),
country_pol_name STRING(100) COLLATE 'und:ci',
src_waers STRING(40),
src_spras STRING(40),
curr_cd STRING(20),
lang_cd STRING(20),
iso_code2 STRING(20),
iso_code3 STRING(20),
member_eu_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);