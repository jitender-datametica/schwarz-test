CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_kaufland_retail_pmr_overflows_2 (
id BIGNUMERIC(38,0) NOT NULL,
dependent_test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
matnr STRING(40),
lifnr STRING(10),
infnr STRING(10),
ekorg STRING(4),
werks STRING(4),
sperr STRING(1),
loevm STRING(1),
idq_date DATETIME,
PRIMARY KEY (id) NOT ENFORCED
);