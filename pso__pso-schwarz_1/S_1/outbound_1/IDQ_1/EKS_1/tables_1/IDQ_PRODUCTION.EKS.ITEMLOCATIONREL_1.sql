CREATE OR REPLACE TABLE idq_production_eks.itemlocationrel_1 (
itemlocationrelid INTEGER NOT NULL,
contractpricevalidityid INTEGER,
locationid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
PRIMARY KEY (itemlocationrelid) NOT ENFORCED
);