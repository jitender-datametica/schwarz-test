CREATE OR REPLACE TABLE idq_production_syscomp.comp_scope_table_execution_historical (
id BIGNUMERIC(38,0) NOT NULL,
comp_scope_execution_id BIGNUMERIC(38,0),
comp_definition_scope_table_id BIGNUMERIC(38,0),
execution_date DATETIME,
execution_day_id BIGNUMERIC(38,0),
leading_amount BIGNUMERIC(38,0),
dependent_amount BIGNUMERIC(38,0),
match_amount BIGNUMERIC(38,0),
missing_amount BIGNUMERIC(38,0),
overflow_amount BIGNUMERIC(38,0),
ambiguous_amount BIGNUMERIC(38,0),
PRIMARY KEY (id) NOT ENFORCED
);