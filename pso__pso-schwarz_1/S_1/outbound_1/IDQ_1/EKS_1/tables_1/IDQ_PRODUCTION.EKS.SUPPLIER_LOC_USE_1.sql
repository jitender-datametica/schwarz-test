CREATE OR REPLACE TABLE idq_production_eks.supplier_loc_use_1 (
supplierno BIGNUMERIC(38,0),
locationid BIGNUMERIC(38,0),
cr_loc_flag BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);