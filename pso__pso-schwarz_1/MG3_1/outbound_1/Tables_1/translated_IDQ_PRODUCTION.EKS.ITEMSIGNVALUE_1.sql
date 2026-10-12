CREATE OR REPLACE TABLE idq_production_eks.itemsignvalue_1 (
itemsignvalid INTEGER NOT NULL,
contractpricevalidityid INTEGER,
signid INTEGER,
signspecid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
signspecvalid INTEGER,
freetext STRING(80),
PRIMARY KEY (itemsignvalid) NOT ENFORCED
);