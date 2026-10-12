CREATE OR REPLACE TABLE idq_production_eks.itemcasepaldef (
itemcasepaldefid INTEGER NOT NULL,
contractpricevalidityid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
casesperply1 BIGNUMERIC(38,0),
casesperply2 BIGNUMERIC(38,0),
plycount1 BIGNUMERIC(38,0),
plycount2 BIGNUMERIC(38,0),
usage BIGNUMERIC(38,0),
PRIMARY KEY (itemcasepaldefid) NOT ENFORCED
);