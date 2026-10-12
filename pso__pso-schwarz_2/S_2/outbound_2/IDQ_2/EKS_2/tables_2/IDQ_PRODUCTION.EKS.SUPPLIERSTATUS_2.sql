CREATE OR REPLACE TABLE idq_production_eks.supplierstatus_2 (
supplierno BIGNUMERIC(38,0),
statusid BIGNUMERIC(38,0),
datefrom DATETIME,
dateuntil DATETIME,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);