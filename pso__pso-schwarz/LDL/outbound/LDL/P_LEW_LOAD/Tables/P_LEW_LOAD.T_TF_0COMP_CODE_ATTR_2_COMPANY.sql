CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_0comp_code_attr_2_company (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
comp_code_attr_bukrs STRING(8),
src_bukrs STRING(20),
src_addrnumber STRING(40),
comp_name STRING(100) COLLATE 'und:ci',
city STRING(100) COLLATE 'und:ci',
account_plan_cd STRING(20),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);