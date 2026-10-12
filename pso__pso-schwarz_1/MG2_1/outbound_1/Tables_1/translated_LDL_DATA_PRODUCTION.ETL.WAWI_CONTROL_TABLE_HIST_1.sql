CREATE OR REPLACE TABLE ldl_data_production_etl.wawi_control_table_hist_1 (
load_id INTEGER NOT NULL,
source_table_name STRING(99) NOT NULL,
begin_tmsp DATETIME NOT NULL,
end_tmsp DATETIME,
rec_count INTEGER NOT NULL,
source_status STRING(1) NOT NULL,
created_tmsp DATETIME,
PRIMARY KEY (source_table_name, begin_tmsp) NOT ENFORCED
);