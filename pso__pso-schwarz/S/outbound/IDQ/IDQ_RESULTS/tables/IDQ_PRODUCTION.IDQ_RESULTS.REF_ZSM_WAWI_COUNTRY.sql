CREATE OR REPLACE TABLE idq_production_idq_results.ref_zsm_wawi_country (
id BIGNUMERIC(38,0) NOT NULL,
ref_country_id BIGNUMERIC(38,0),
country_name STRING(50),
country_code STRING(3),
wawi_country_code STRING(30),
wawi_dbconnection STRING(100),
zsm_ekorg STRING(4)
);