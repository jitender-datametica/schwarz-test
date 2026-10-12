CREATE OR REPLACE TABLE idq_production_eks.itemalternation (
itemalternationid INTEGER NOT NULL,
contractpricevalidityid INTEGER,
datefrom DATETIME,
dateuntil DATETIME,
itemid INTEGER,
sortingorder INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
frequencetimeunitid INTEGER,
frequencefactor INTEGER,
PRIMARY KEY (itemalternationid) NOT ENFORCED
);