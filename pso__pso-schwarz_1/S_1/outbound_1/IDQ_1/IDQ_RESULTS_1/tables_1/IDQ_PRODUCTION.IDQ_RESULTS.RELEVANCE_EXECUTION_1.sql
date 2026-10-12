CREATE OR REPLACE TABLE idq_production_idq_results.relevance_execution_1 (
id BIGNUMERIC(38,0) NOT NULL,
relevance_definition_id BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
test_time DATETIME,
PRIMARY KEY (id) NOT ENFORCED
);