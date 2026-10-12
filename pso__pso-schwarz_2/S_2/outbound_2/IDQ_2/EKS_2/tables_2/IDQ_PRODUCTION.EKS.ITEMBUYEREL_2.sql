CREATE OR REPLACE TABLE idq_production_eks.itembuyerel_2 (
itembuyerelid BIGNUMERIC(38,0),
itemid BIGNUMERIC(38,0),
employeeid BIGNUMERIC(38,0),
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