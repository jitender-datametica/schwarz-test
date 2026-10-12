CREATE OR REPLACE TABLE idq_production_eks.supplierstatus (
supplierno INTEGER,
statusid INTEGER,
datefrom DATETIME,
dateuntil DATETIME,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);