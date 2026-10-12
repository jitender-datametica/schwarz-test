CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_syscomp_wawi_zsm_supplier (
id INTEGER NOT NULL,
leading_primary_key STRING(1000),
dependent_primary_key STRING(1000),
leading_system_id INTEGER,
dependent_system_id INTEGER,
branch_id INTEGER,
country_id INTEGER,
c216_int_suppnr STRING(10),
wawi_name STRING(100),
int_buy_country STRING(3),
c0606_reason_for_relevance STRING(250),
zsm_name STRING(100),
warenbereiche STRING(300),
suchname STRING(30),
sap_kred_link STRING(1),
content_hash_code STRING(1000)
);