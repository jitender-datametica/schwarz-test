CREATE OR REPLACE TABLE idq_production_eks.itemintrastat_2 (
itemintrastatid INTEGER,
itemid INTEGER,
intrastat STRING(11),
active INTEGER,
manuell INTEGER,
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
special_unit_value STRING(255),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);