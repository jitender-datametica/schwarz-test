CREATE OR REPLACE TABLE idq_production_eks.palletdimension_2 (
palletdimid INTEGER NOT NULL,
pallettypeid INTEGER,
totaldim INTEGER,
unitid INTEGER,
weightunitid INTEGER,
height NUMERIC(10,2),
width NUMERIC(10,2),
depth NUMERIC(10,2),
weight NUMERIC(10,3),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
PRIMARY KEY (palletdimid) NOT ENFORCED
);