CREATE OR REPLACE TABLE idq_production_idq_results.ref_dq_status_loader_source_table (
id BIGNUMERIC(38,0) NOT NULL,
branch_id BIGNUMERIC(38,0) NOT NULL,
source_system_type_id BIGNUMERIC(38,0) NOT NULL,
table_name STRING(400),
country_id_list STRING(400)
);