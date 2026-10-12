CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_report_parameter_1 (
report STRING(50),
entry_no BIGNUMERIC(38,0),
parameter_type STRING(50),
parameter_name STRING(50),
parameter_value_char STRING(50),
parameter_value_numeric BIGNUMERIC(38,5),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP
);