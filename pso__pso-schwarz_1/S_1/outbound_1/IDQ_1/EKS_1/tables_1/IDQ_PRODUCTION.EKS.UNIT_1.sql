CREATE OR REPLACE TABLE idq_production_eks.unit_1 (
unitid BIGNUMERIC(38,0),
scale BIGNUMERIC(38,0),
editable BIGNUMERIC(38,0),
unittypeid BIGNUMERIC(38,0),
descriptionid BIGNUMERIC(38,0),
shortdescid BIGNUMERIC(38,0),
factor BIGNUMERIC(20,11),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);