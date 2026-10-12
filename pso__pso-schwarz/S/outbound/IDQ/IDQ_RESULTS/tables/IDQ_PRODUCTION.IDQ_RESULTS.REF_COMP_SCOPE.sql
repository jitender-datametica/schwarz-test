CREATE OR REPLACE TABLE idq_production_idq_results.ref_comp_scope (
id BIGNUMERIC(38,0) NOT NULL,
source_system_type_id BIGNUMERIC(38,0),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
test_object_type_id BIGNUMERIC(38,0),
description_de STRING(1000),
description_en STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
);