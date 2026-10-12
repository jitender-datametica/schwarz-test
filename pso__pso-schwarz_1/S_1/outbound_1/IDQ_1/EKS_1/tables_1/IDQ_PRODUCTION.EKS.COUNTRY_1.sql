CREATE OR REPLACE TABLE idq_production_eks.country_1 (
countryid BIGNUMERIC(38,0),
visibleflag BIGNUMERIC(38,0),
countryisonum BIGNUMERIC(38,0),
orgaid BIGNUMERIC(38,0),
languageid BIGNUMERIC(38,0),
currencyid BIGNUMERIC(38,0),
countrycode STRING(2),
countryiso3 STRING(3),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
description STRING(80),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);