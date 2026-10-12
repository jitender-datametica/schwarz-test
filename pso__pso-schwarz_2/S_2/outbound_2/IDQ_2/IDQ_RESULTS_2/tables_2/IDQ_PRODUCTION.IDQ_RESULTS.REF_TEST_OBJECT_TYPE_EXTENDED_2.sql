CREATE OR REPLACE TABLE idq_production_idq_results.ref_test_object_type_extended_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_type STRING(1000) NOT NULL,
level_1_id BIGNUMERIC(38,0) NOT NULL,
level_2_id BIGNUMERIC(38,0),
level_3_id BIGNUMERIC(38,0),
name_de STRING(1000),
name_en STRING(1000),
change_by STRING(1000),
last_change DATETIME,
from_date DATETIME,
to_date DATETIME,
sorting_order BIGNUMERIC(38,0),
PRIMARY KEY (id) NOT ENFORCED
);