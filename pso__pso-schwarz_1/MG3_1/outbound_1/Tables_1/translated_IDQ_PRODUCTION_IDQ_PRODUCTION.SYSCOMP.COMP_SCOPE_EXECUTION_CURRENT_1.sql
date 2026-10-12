CREATE OR REPLACE TABLE idq_production_syscomp.comp_scope_execution_current_1 (
id INTEGER NOT NULL,
comp_definition_scope_id INTEGER,
execution_date DATETIME,
execution_day_id INTEGER,
leading_amount INTEGER,
dependent_amount INTEGER,
match_amount INTEGER,
missing_amount INTEGER,
overflow_amount INTEGER,
ambiguous_amount INTEGER,
incomplete_amount INTEGER,
scope_id INTEGER,
PRIMARY KEY (id) NOT ENFORCED
);