CREATE OR REPLACE TABLE idq_production_eks.status_2 (
statusid BIGNUMERIC(38,0),
visibleflag BIGNUMERIC(38,0),
statusno BIGNUMERIC(38,0),
statustypeid BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
shortdesc STRING(25),
cruser STRING(35),
moduser STRING(35),
description STRING(80),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);