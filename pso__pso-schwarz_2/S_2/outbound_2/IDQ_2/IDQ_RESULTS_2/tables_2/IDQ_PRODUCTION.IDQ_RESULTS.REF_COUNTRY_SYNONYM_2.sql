CREATE OR REPLACE TABLE idq_production_idq_results.ref_country_synonym_2 (
id BIGNUMERIC(38,0) NOT NULL,
country_id BIGNUMERIC(38,0),
synonym_value STRING(1000),
PRIMARY KEY (id) NOT ENFORCED
);