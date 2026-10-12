CREATE OR REPLACE TABLE idq_production_eks.brand_1 (
brandid BIGNUMERIC(38,0),
brandtypeid BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
description STRING(80),
brandno BIGNUMERIC(38,0),
brandsignid BIGNUMERIC(38,0),
locationid BIGNUMERIC(38,0),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);