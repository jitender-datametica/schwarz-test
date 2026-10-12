CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_hac2_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(100),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
name STRING(32),
virtual_hostname STRING(32),
physical_hostname STRING(32),
url STRING(256),
is_country_system STRING(10)
);