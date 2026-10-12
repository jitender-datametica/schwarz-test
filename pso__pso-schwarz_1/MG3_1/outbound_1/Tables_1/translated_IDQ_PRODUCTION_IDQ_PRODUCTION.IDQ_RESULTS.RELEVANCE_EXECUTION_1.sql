CREATE OR REPLACE TABLE idq_production_idq_results.relevance_execution_1 (
id INTEGER NOT NULL,
relevance_definition_id INTEGER,
source_system_id INTEGER,
country_id INTEGER,
test_time DATETIME,
PRIMARY KEY (id) NOT ENFORCED
);