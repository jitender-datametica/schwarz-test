CREATE OR REPLACE TABLE idq_production_zsm.t005t_1 (
mandt STRING(3),
spras STRING(1) NOT NULL,
land1 STRING(3) NOT NULL,
landx STRING(15),
natio STRING(15),
landx50 STRING(50),
natio50 STRING(50),
prq_spregt STRING(30),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP,
PRIMARY KEY (spras, land1) NOT ENFORCED
);