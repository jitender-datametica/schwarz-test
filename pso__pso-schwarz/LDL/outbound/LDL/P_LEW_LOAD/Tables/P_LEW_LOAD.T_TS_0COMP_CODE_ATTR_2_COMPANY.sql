CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_0comp_code_attr_2_company (
record_id INTEGER,
client_id BIGNUMERIC(38),
comp_sid BIGNUMERIC(38),
src_bukrs STRING(20),
addr_sid BIGNUMERIC(38),
comp_name STRING(100) COLLATE 'und:ci',
city STRING(100) COLLATE 'und:ci',
account_plan_cd STRING(20),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);