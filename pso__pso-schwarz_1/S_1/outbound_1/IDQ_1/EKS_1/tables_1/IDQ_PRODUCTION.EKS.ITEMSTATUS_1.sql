CREATE OR REPLACE TABLE idq_production_eks.itemstatus_1 (
itemid INTEGER NOT NULL,
statusid BIGNUMERIC(38,0) NOT NULL,
datefrom DATETIME NOT NULL,
dateuntil DATETIME,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
PRIMARY KEY (itemid, statusid, datefrom) NOT ENFORCED
);