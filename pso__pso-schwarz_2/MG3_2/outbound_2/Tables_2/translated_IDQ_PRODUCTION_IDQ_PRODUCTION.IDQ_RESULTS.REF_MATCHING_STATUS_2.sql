CREATE OR REPLACE TABLE idq_production_idq_results.ref_matching_status_2 (
id INTEGER NOT NULL,
matching_status STRING(200),
name_de STRING(1000),
name_en STRING(1000),
description_de STRING(4000),
description_en STRING(4000),
PRIMARY KEY (id) NOT ENFORCED
);