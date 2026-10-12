DROP TABLE IF EXISTS idq_production_idq_results.idq_test_object_2;
CREATE OR REPLACE TABLE idq_production_idq_results.idq_test_object_2 (
id BIGNUMERIC(38,0) NOT NULL,
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000) NOT NULL,
source_system_id BIGNUMERIC(38,0),
ldo_num BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
name STRING(1000),
test_object_type_id BIGNUMERIC(38,0),
source_system_status STRING(200),
is_relevant BIGNUMERIC(38,0),
first_unsuccessful_load DATETIME,
unsuccessful_load_message STRING(500),
first_unsuccessful_load_day_id BIGNUMERIC(38,0),
functional_id STRING(1000),
last_update DATETIME,
PRIMARY KEY (id) NOT ENFORCED
) CLUSTER BY test_object_type_id, source_system_id, country_id, branch_id;