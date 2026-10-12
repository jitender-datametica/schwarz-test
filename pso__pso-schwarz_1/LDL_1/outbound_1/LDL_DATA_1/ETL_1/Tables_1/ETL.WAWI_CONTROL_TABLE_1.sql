CREATE TABLE IF NOT EXISTS ldl_data_etl.wawi_control_table_1 (
source_table_name STRING(99) NOT NULL,
begin_tmsp DATETIME NOT NULL,
end_tmsp DATETIME,
rec_count BIGNUMERIC(38,0) NOT NULL,
source_status STRING(1) NOT NULL,
updated_tmsp DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME),
PRIMARY KEY (source_table_name, begin_tmsp) NOT ENFORCED
);