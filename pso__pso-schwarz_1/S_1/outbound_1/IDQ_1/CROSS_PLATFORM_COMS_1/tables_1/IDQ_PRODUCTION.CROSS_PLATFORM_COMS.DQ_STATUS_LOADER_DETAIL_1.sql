CREATE OR REPLACE TABLE idq_production_cross_platform_coms.dq_status_loader_detail_1 (
id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0) NOT NULL,
source_system_type_id BIGNUMERIC(38,0) NOT NULL,
country_id BIGNUMERIC(38,0) NOT NULL,
loader_source_table_id BIGNUMERIC(38,0) NOT NULL,
data_load_start TIMESTAMP NOT NULL,
data_load_end TIMESTAMP,
data_load_status_id BIGNUMERIC(38,0) NOT NULL,
checklist_id STRING(400) NOT NULL,
load_type STRING(10) NOT NULL,
number_of_records BIGNUMERIC(38,0),
number_of_rejected_records BIGNUMERIC(38,0)
);