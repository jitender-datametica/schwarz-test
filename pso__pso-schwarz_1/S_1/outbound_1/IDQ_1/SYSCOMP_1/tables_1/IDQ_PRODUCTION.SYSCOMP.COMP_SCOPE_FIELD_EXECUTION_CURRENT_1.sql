CREATE OR REPLACE TABLE idq_production_syscomp.comp_scope_field_execution_current_1 (
comp_scope_execution_id BIGNUMERIC(38,0),
field_comp_definition_id BIGNUMERIC(38,0),
execution_date DATETIME,
execution_day_id BIGNUMERIC(38,0),
match_amount BIGNUMERIC(38,0),
equal_amount BIGNUMERIC(38,0),
unequal_amount BIGNUMERIC(38,0),
leading_empty BIGNUMERIC(38,0),
dependent_empty BIGNUMERIC(38,0),
scope_id BIGNUMERIC(38,0)
);