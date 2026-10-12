CREATE OR REPLACE TABLE idq_production_eks.itemsignvalue_1 (
itemsignvalid INTEGER NOT NULL,
contractpricevalidityid INTEGER,
signid BIGNUMERIC(38,0),
signspecid BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
signspecvalid BIGNUMERIC(38,0),
freetext STRING(80),
PRIMARY KEY (itemsignvalid) NOT ENFORCED
);