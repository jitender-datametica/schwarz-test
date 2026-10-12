CREATE OR REPLACE TABLE idq_production_eks.itemean_location (
itemeanid BIGNUMERIC(38,0),
locationid BIGNUMERIC(38,0),
itemid BIGNUMERIC(38,0),
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);