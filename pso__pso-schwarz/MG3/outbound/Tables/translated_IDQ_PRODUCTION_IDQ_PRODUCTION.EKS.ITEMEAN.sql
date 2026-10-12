CREATE OR REPLACE TABLE idq_production_eks.itemean (
itemeanid INTEGER,
itemid INTEGER,
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