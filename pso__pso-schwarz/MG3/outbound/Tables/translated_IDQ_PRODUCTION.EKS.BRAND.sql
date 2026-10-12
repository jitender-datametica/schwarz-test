CREATE OR REPLACE TABLE idq_production_eks.brand (
brandid INTEGER,
brandtypeid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
description STRING(80),
brandno INTEGER,
brandsignid INTEGER,
locationid INTEGER,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);