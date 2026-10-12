CREATE OR REPLACE TABLE idq_production_eks.contractpricevalidity_2 (
contractpricevalidityid BIGNUMERIC(38,0),
contractpricerelid BIGNUMERIC(38,0),
adsflg BIGNUMERIC(38,0),
datefrom DATETIME,
dateuntil DATETIME,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
validityid BIGNUMERIC(38,0),
basecpvid BIGNUMERIC(38,0),
pred_cpvid BIGNUMERIC(38,0),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);