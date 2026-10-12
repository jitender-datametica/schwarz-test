CREATE OR REPLACE TABLE idq_production_eks.itemintrastat_2 (
itemintrastatid BIGNUMERIC(30,0),
itemid BIGNUMERIC(38,0),
intrastat STRING(11),
active BIGNUMERIC(38,0),
manuell BIGNUMERIC(38,0),
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
special_unit_value STRING(255),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);