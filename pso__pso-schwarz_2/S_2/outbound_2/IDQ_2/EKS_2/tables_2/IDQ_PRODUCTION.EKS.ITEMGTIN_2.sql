CREATE OR REPLACE TABLE idq_production_eks.itemgtin_2 (
itemgtinid BIGNUMERIC(38,0),
no_gtin BIGNUMERIC(38,0),
is_auto BIGNUMERIC(38,0),
itemid BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
casesize STRING(255),
gtin STRING(255),
zgtin_wozeros STRING(255),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);