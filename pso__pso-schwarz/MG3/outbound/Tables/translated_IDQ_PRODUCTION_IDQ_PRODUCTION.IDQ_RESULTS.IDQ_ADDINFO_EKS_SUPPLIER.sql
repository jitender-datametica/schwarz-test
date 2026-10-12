CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_eks_supplier (
id INTEGER NOT NULL,
test_object_id INTEGER,
branch_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
supplierno STRING(10),
intsupplierno STRING(10),
shortdesc STRING(30),
description STRING(80),
suppliercatid INTEGER,
itemgrouptypeid STRING(10),
is_relevant INTEGER,
sap_id STRING(15),
itemsubgrouptypeids STRING(200),
resp_country STRING(10),
PRIMARY KEY (id) NOT ENFORCED
);