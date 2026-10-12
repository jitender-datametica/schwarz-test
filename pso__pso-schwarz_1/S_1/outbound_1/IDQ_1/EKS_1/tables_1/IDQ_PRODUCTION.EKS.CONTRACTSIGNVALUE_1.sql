CREATE OR REPLACE TABLE idq_production_eks.contractsignvalue_1 (
contractsignvalueid BIGNUMERIC(38,0),
signid BIGNUMERIC(38,0),
signspecid BIGNUMERIC(38,0),
contractlinkid BIGNUMERIC(38,0),
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
signspecvalid BIGNUMERIC(38,0),
freetext STRING(80),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);