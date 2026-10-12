CREATE OR REPLACE TABLE idq_production_eks.itemweight_1 (
itemweightid INTEGER NOT NULL,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
itemid INTEGER,
contractpricevalidityid INTEGER,
unitid INTEGER,
caseunitid INTEGER,
grossweight NUMERIC(8,3),
netweight NUMERIC(8,3),
drainweight NUMERIC(8,3),
casegrossweight NUMERIC(8,3),
palletweight NUMERIC(8,3),
PRIMARY KEY (itemweightid) NOT ENFORCED
);