CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_eks_supplier (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
supplierno STRING(10),
intsupplierno STRING(10),
shortdesc STRING(30),
description STRING(80),
suppliercatid BIGNUMERIC(38,0),
itemgrouptypeid STRING(10),
is_relevant BIGNUMERIC(38,0),
sap_id STRING(15),
itemsubgrouptypeids STRING(200),
resp_country STRING(10),
PRIMARY KEY (id) NOT ENFORCED
);