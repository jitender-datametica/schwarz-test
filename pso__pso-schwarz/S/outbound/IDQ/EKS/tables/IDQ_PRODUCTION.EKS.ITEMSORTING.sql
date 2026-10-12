CREATE OR REPLACE TABLE idq_production_eks.itemsorting (
sortitemid BIGNUMERIC(38,0),
itemid BIGNUMERIC(38,0),
quantity BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);