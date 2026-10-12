CREATE OR REPLACE TABLE idq_production_eks.translation_int_1 (
translationid BIGNUMERIC(38,0),
checkid BIGNUMERIC(38,0),
pkid BIGNUMERIC(38,0),
translation_fieldid BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
description STRING(200),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);