CREATE OR REPLACE TABLE idq_production_eks.itemalternation_1 (
itemalternationid INTEGER NOT NULL,
contractpricevalidityid INTEGER,
datefrom DATETIME,
dateuntil DATETIME,
itemid INTEGER,
sortingorder_1 INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
frequencetimeunitid INTEGER,
frequencefactor INTEGER,
PRIMARY KEY (itemalternationid) NOT ENFORCED
);