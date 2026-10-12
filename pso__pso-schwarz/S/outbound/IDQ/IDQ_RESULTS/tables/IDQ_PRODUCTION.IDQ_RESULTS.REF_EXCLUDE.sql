CREATE OR REPLACE TABLE idq_production_idq_results.ref_exclude (
id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
test_object_type_id BIGNUMERIC(38,0),
inserted_by STRING(200),
exclude_reason STRING(1000),
exclude_flag BIGNUMERIC(38,0),
inserted_at DATETIME,
undone_at DATETIME,
test_object_id BIGNUMERIC(38,0)
);