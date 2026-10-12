CREATE OR REPLACE TABLE idq_production_eks.itemsign (
itemsignid BIGNUMERIC(38,0) NOT NULL,
signid BIGNUMERIC(38,0),
itemid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
signspecid BIGNUMERIC(38,0),
signspecvalid BIGNUMERIC(38,0),
shortdesc STRING(25),
PRIMARY KEY (itemsignid) NOT ENFORCED
);