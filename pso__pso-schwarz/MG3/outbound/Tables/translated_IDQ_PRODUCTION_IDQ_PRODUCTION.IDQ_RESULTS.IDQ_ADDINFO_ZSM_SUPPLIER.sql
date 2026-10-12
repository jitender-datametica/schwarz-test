CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_zsm_supplier (
id INTEGER NOT NULL,
test_object_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
branch_id INTEGER,
is_relevant INTEGER,
zz_net_country STRING(3),
conet_country STRING(2000),
PRIMARY KEY (id) NOT ENFORCED
);