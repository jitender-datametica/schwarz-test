CREATE OR REPLACE TABLE idq_production_eks.itemweight (
itemweightid INTEGER NOT NULL,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
itemid INTEGER,
contractpricevalidityid INTEGER,
unitid BIGNUMERIC(38,0),
caseunitid BIGNUMERIC(38,0),
grossweight NUMERIC(8,3),
netweight NUMERIC(8,3),
drainweight NUMERIC(8,3),
casegrossweight NUMERIC(8,3),
palletweight NUMERIC(8,3),
PRIMARY KEY (itemweightid) NOT ENFORCED
);