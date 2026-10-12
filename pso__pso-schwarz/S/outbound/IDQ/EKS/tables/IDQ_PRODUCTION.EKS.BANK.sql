CREATE OR REPLACE TABLE idq_production_eks.bank (
bankid BIGNUMERIC(38,0),
countryid BIGNUMERIC(38,0),
visibleflag BIGNUMERIC(38,0),
moddate STRING(40),
crdate STRING(40),
moduser STRING(35),
cruser STRING(35),
name STRING(80),
bicky STRING(8),
zipcode STRING(10),
swiftcode STRING(11),
sortcode STRING(20),
street STRING(40),
city STRING(40),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);