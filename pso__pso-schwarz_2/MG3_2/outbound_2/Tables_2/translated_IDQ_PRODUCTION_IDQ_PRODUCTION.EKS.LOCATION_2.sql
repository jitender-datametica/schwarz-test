CREATE OR REPLACE TABLE idq_production_eks.location_2 (
locationid INTEGER,
parentid INTEGER,
moddate DATETIME,
crdate DATETIME,
locationno STRING(5),
shortsign STRING(5),
shortdesc STRING(25),
moduser STRING(35),
cruser STRING(35),
description STRING(80),
locregulateid INTEGER,
iln INTEGER,
contractname STRING(80),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);