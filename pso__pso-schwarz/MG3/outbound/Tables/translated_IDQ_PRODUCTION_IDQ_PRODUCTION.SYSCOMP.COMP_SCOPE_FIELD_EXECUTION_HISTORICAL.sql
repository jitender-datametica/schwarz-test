CREATE OR REPLACE TABLE idq_production_syscomp.comp_scope_field_execution_historical (
comp_scope_execution_id INTEGER,
field_comp_definition_id INTEGER,
execution_date DATETIME,
execution_day_id INTEGER,
match_amount INTEGER,
equal_amount INTEGER,
unequal_amount INTEGER,
leading_empty INTEGER,
dependent_empty INTEGER,
scope_id INTEGER
);