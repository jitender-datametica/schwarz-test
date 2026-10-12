CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_hac2_hosts_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(100),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
physical_hostname STRING(100),
url STRING(1000)
);