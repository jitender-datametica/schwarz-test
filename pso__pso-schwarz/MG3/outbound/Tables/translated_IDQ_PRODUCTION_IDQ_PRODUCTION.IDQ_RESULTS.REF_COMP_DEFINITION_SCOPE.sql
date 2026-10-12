CREATE OR REPLACE TABLE idq_production_idq_results.ref_comp_definition_scope (
id INTEGER NOT NULL,
comp_definition_id INTEGER,
leading_comp_scope_id INTEGER,
dependent_comp_scope_id INTEGER,
status_id INTEGER,
application_scope_id INTEGER,
PRIMARY KEY (id) NOT ENFORCED
);