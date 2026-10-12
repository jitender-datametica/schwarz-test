CREATE OR REPLACE TABLE idq_production_eks.translation_int (
translationid INTEGER,
checkid INTEGER,
pkid INTEGER,
translation_fieldid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
description STRING(200),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);