CREATE TABLE IF NOT EXISTS ldl_data_etl.wawi_control_table_20240108_1421 (
source_table_name STRING(99),
begin_tmsp DATETIME,
end_tmsp DATETIME,
rec_count BIGNUMERIC(38,0),
source_status STRING(1),
updated_tmsp DATETIME
);