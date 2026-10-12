CREATE OR REPLACE TABLE idq_production_idq_results.check_dq_by_field_historical_2 (
test_object_type_id BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
source_system_type_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
field_id BIGNUMERIC(38,0),
calculation_time DATETIME,
calculation_day_id BIGNUMERIC(38,0),
score NUMERIC(10,2),
test_object_amount BIGNUMERIC(38,0),
is_usable BIGNUMERIC(38,0)
);