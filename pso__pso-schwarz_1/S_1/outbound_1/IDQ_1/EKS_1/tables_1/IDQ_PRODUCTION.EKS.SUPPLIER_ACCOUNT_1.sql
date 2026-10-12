CREATE OR REPLACE TABLE idq_production_eks.supplier_account_1 (
supplaccountid BIGNUMERIC(38,0),
supplierno BIGNUMERIC(38,0),
accountid BIGNUMERIC(38,0),
datefrom STRING(40),
dateuntil STRING(40),
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
email STRING(120),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);