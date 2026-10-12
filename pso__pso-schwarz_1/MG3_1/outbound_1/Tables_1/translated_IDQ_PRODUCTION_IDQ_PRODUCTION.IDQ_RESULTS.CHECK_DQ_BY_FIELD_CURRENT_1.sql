CREATE OR REPLACE TABLE idq_production_idq_results.check_dq_by_field_current_1 (
scope_id INTEGER,
test_object_type_id INTEGER,
source_system_id INTEGER,
source_system_type_id INTEGER,
branch_id INTEGER,
country_id INTEGER,
field_id INTEGER,
calculation_time DATETIME,
calculation_day_id INTEGER,
score NUMERIC(10,2),
test_object_amount INTEGER,
is_usable INTEGER
);