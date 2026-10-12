CREATE OR REPLACE TABLE idq_production_idq_results.ref_comp_definition_scope_table (
id INTEGER NOT NULL,
comp_definition_scope_id INTEGER,
table_leading STRING(200),
table_dependent STRING(200),
PRIMARY KEY (id) NOT ENFORCED
);