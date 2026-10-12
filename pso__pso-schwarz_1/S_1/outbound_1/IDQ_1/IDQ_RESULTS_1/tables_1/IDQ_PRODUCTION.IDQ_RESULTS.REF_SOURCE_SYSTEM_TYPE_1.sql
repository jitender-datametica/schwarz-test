DROP TABLE IF EXISTS idq_production_idq_results.ref_source_system_type_1;
CREATE OR REPLACE TABLE idq_production_idq_results.ref_source_system_type_1 (
id BIGNUMERIC(38,0) NOT NULL,
name STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
) CLUSTER BY id;