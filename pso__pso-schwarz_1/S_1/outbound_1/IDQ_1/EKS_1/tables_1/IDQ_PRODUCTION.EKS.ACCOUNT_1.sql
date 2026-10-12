CREATE OR REPLACE TABLE idq_production_eks.account_1 (
accountid BIGNUMERIC(38,0),
bankid BIGNUMERIC(38,0),
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
checkkey STRING(2),
accountno STRING(18),
iban STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);