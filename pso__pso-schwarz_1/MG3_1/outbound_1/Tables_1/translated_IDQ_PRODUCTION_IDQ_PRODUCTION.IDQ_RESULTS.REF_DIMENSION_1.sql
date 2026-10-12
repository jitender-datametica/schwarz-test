CREATE OR REPLACE TABLE idq_production_idq_results.ref_dimension_1 (
id INTEGER NOT NULL,
dimension STRING(200),
name_de STRING(1000),
name_en STRING(1000),
change_by STRING(1000),
last_change DATETIME,
from_date DATETIME,
to_date DATETIME,
PRIMARY KEY (id) NOT ENFORCED
);