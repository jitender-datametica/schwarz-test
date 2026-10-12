CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_pim_wawi_lief (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
krednr STRING(7),
c216_int_suppnr STRING(10),
name1 STRING(80),
suchname STRING(30),
umsatz_id STRING(20),
int_buy_country STRING(3),
gln STRING(13),
c0606_reason_for_relevance STRING(250),
is_relevant BIGNUMERIC(38,0),
PRIMARY KEY (id) NOT ENFORCED
);