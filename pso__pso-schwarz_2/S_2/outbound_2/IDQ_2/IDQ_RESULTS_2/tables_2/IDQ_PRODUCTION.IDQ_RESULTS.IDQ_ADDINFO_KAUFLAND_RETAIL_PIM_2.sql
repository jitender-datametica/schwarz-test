CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_kaufland_retail_pim_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
at_sap_k_article_number STRING(40),
at_pim_zsmnr STRING(40),
idq_date DATETIME,
PRIMARY KEY (id) NOT ENFORCED
);