CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_zsm_supplier (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
zz_net_country STRING(3),
conet_country STRING(2000),
PRIMARY KEY (id) NOT ENFORCED
);