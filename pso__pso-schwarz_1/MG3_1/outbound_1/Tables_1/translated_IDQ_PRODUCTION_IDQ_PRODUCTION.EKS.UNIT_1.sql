CREATE OR REPLACE TABLE idq_production_eks.unit_1 (
unitid INTEGER,
scale INTEGER,
editable INTEGER,
unittypeid INTEGER,
descriptionid INTEGER,
shortdescid INTEGER,
factor BIGNUMERIC(20,11),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);