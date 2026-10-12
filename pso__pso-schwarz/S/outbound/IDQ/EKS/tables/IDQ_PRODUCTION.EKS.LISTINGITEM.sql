CREATE OR REPLACE TABLE idq_production_eks.listingitem (
listingitemid BIGNUMERIC(38,0),
listingoverviewid BIGNUMERIC(38,0),
itemid BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
moduser STRING(35),
cruser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);