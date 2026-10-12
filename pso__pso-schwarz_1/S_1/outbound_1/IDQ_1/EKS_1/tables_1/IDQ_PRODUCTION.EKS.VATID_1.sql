CREATE OR REPLACE TABLE idq_production_eks.vatid_1 (
vatid_1 BIGNUMERIC(38,0),
countryid BIGNUMERIC(38,0),
defaultflag BIGNUMERIC(38,0),
moddate STRING(40),
crdate STRING(40),
vatno STRING(15),
moduser STRING(35),
cruser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);