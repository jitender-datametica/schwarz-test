CREATE OR REPLACE TABLE idq_production_idq_results.ref_source_system (
id BIGNUMERIC(38,0) NOT NULL,
source_system STRING(1000),
source_system_type_id BIGNUMERIC(38,0),
parent_id BIGNUMERIC(38,0),
change_by STRING(1000),
last_change DATETIME,
from_date DATETIME,
to_date DATETIME,
name_de STRING(1000),
name_en STRING(1000),
sdc_id BIGNUMERIC(38,0),
PRIMARY KEY (id) NOT ENFORCED
);