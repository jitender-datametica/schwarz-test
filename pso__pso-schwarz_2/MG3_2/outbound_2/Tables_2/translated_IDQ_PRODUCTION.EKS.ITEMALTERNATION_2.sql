CREATE OR REPLACE TABLE idq_production_eks.itemalternation_2 (
itemalternationid INTEGER NOT NULL,
contractpricevalidityid INTEGER,
datefrom DATETIME,
dateuntil DATETIME,
itemid INTEGER,
sortingorder_2 INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
frequencetimeunitid INTEGER,
frequencefactor INTEGER,
PRIMARY KEY (itemalternationid) NOT ENFORCED
);