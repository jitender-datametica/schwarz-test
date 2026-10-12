CREATE OR REPLACE TABLE idq_production_eks.itemgrptimeline_2 (
itemgroupid BIGNUMERIC(38,0),
datefrom DATETIME,
parentid BIGNUMERIC(38,0),
itemgrpdescid BIGNUMERIC(38,0),
dateuntil DATETIME,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
shortdesc STRING(25),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);