CREATE OR REPLACE TABLE idq_production_eks.itemgtin (
itemgtinid INTEGER,
no_gtin INTEGER,
is_auto INTEGER,
itemid INTEGER,
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