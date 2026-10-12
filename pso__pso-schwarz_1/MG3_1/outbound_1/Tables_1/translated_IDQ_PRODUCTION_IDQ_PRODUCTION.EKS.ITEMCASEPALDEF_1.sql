CREATE OR REPLACE TABLE idq_production_eks.itemcasepaldef_1 (
itemcasepaldefid INTEGER NOT NULL,
contractpricevalidityid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
casesperply1 INTEGER,
casesperply2 INTEGER,
plycount1 INTEGER,
plycount2 INTEGER,
usage INTEGER,
PRIMARY KEY (itemcasepaldefid) NOT ENFORCED
);