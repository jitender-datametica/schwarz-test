CREATE OR REPLACE TABLE idq_production_eks.hierarchy (
hierarchyid BIGNUMERIC(38,0),
internalflag BIGNUMERIC(38,0),
position BIGNUMERIC(38,0),
crdate STRING(40),
moddate STRING(40),
shortdesc STRING(25),
cruser STRING(35),
moduser STRING(35),
description STRING(80),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);