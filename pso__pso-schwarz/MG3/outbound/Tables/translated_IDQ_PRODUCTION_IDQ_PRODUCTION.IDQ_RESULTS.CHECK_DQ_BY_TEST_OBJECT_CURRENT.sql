DROP TABLE IF EXISTS idq_production_idq_results.check_dq_by_test_object_current;
CREATE OR REPLACE TABLE idq_production_idq_results.check_dq_by_test_object_current (
scope_id INTEGER,
test_object_id INTEGER,
test_object_type_id INTEGER,
source_system_type_id INTEGER,
branch_id INTEGER,
country_id INTEGER,
calculation_time DATETIME,
calculation_day_id INTEGER,
penalty INTEGER,
score INTEGER,
field_amount INTEGER,
is_usable INTEGER
) CLUSTER BY test_object_id;