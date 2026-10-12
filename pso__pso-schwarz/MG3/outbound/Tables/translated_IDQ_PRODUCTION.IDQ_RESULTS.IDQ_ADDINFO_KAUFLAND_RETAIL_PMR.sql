CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_kaufland_retail_pmr (
id INTEGER NOT NULL,
test_object_id INTEGER,
branch_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
is_relevant INTEGER,
matnr STRING(40),
lifnr STRING(10),
infnr STRING(10),
ekorg STRING(4),
werks STRING(4),
idq_date DATETIME,
PRIMARY KEY (id) NOT ENFORCED
);