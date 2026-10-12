CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_wawi_lief (
id INTEGER NOT NULL,
test_object_id INTEGER,
branch_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
krednr STRING(7),
c216_int_suppnr STRING(10),
name1 STRING(80),
suchname STRING(30),
umsatz_id STRING(20),
int_buy_country STRING(3),
gln STRING(13),
c0606_reason_for_relevance STRING(250),
is_relevant INTEGER,
PRIMARY KEY (id) NOT ENFORCED
);