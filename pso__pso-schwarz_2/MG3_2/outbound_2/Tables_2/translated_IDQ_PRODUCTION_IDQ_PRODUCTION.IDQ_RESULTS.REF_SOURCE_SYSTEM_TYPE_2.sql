DROP TABLE IF EXISTS idq_production_idq_results.ref_source_system_type_2;
CREATE OR REPLACE TABLE idq_production_idq_results.ref_source_system_type_2 (
id INTEGER NOT NULL,
name STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
) CLUSTER BY id;