CREATE OR REPLACE TABLE idq_production_cross_platform_coms.dq_status_2 (
id INTEGER,
process_type_id INTEGER NOT NULL,
branch_id INTEGER NOT NULL,
source_system_type_id INTEGER,
comp_definition_id INTEGER,
country_id INTEGER NOT NULL,
process_start TIMESTAMP NOT NULL,
process_end TIMESTAMP,
process_status_id INTEGER NOT NULL,
workflow_id STRING(400) NOT NULL,
subsystem STRING(100)
);