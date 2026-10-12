CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_syscomp_wawi_supplier_1 (
id INTEGER NOT NULL,
test_object_id INTEGER,
branch_id INTEGER,
source_system_primary_key STRING(1000),
is_relevant INTEGER,
source_system_id INTEGER,
country_id INTEGER,
krednr STRING(7),
suchname STRING(30),
gueltig_ab DATETIME,
content_hash_code STRING(32)
);