CREATE OR REPLACE TABLE idq_production_eks.contractpricevalidity_2 (
contractpricevalidityid INTEGER,
contractpricerelid INTEGER,
adsflg INTEGER,
datefrom DATETIME,
dateuntil DATETIME,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
validityid INTEGER,
basecpvid INTEGER,
pred_cpvid INTEGER,
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);