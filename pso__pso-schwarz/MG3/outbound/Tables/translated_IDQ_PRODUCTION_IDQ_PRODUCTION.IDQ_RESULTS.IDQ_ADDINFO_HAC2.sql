CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_hac2 (
id INTEGER NOT NULL,
test_object_id INTEGER,
branch_id INTEGER,
source_system_primary_key STRING(100),
source_system_id INTEGER,
country_id INTEGER,
is_relevant INTEGER,
name STRING(32),
virtual_hostname STRING(32),
physical_hostname STRING(32),
url STRING(256),
is_country_system STRING(10)
);