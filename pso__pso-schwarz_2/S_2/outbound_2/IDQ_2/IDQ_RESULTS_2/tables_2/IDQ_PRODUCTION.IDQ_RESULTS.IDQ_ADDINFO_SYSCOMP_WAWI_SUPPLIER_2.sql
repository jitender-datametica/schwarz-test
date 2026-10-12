CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_syscomp_wawi_supplier_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
is_relevant BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
krednr STRING(7),
suchname STRING(30),
gueltig_ab DATETIME,
content_hash_code STRING(32)
);