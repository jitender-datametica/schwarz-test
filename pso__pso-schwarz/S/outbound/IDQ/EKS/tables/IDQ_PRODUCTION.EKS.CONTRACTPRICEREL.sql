CREATE OR REPLACE TABLE idq_production_eks.contractpricerel (
contractpricerelid BIGNUMERIC(38,0),
contractlinkid BIGNUMERIC(38,0),
basicpriceid BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);