CREATE OR REPLACE TABLE idq_production_cross_platform_coms.dq_status_loader_detail_1 (
id INTEGER,
branch_id INTEGER NOT NULL,
source_system_type_id INTEGER NOT NULL,
country_id INTEGER NOT NULL,
loader_source_table_id INTEGER NOT NULL,
data_load_start TIMESTAMP NOT NULL,
data_load_end TIMESTAMP,
data_load_status_id INTEGER NOT NULL,
checklist_id STRING(400) NOT NULL,
load_type STRING(10) NOT NULL,
number_of_records INTEGER,
number_of_rejected_records INTEGER
);