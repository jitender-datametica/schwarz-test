CREATE OR REPLACE TABLE idq_production_cross_platform_coms.dq_status_2 (
id BIGNUMERIC(38,0),
process_type_id BIGNUMERIC(38,0) NOT NULL,
branch_id BIGNUMERIC(38,0) NOT NULL,
source_system_type_id BIGNUMERIC(38,0),
comp_definition_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0) NOT NULL,
process_start TIMESTAMP NOT NULL,
process_end TIMESTAMP,
process_status_id BIGNUMERIC(38,0) NOT NULL,
workflow_id STRING(400) NOT NULL,
subsystem STRING(100)
);