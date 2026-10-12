CREATE OR REPLACE TABLE idq_production_eks.itemsign_1 (
itemsignid INTEGER NOT NULL,
signid INTEGER,
itemid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
signspecid INTEGER,
signspecvalid INTEGER,
shortdesc STRING(25),
PRIMARY KEY (itemsignid) NOT ENFORCED
);