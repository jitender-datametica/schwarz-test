CREATE OR REPLACE TABLE idq_production_eks.itemean (
itemeanid BIGNUMERIC(38,0),
itemid BIGNUMERIC(38,0),
ean STRING(13),
datefrom DATETIME,
dateuntil DATETIME,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
zean_wozeros STRING(13),
zean_converted STRING(13),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);