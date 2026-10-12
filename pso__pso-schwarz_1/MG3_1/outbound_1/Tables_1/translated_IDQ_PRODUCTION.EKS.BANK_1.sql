CREATE OR REPLACE TABLE idq_production_eks.bank_1 (
bankid INTEGER,
countryid INTEGER,
visibleflag INTEGER,
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