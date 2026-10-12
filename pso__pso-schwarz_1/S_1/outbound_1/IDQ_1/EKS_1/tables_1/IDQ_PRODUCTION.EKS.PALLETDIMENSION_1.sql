CREATE OR REPLACE TABLE idq_production_eks.palletdimension_1 (
palletdimid BIGNUMERIC(38,0) NOT NULL,
pallettypeid BIGNUMERIC(38,0),
totaldim BIGNUMERIC(38,0),
unitid BIGNUMERIC(38,0),
weightunitid BIGNUMERIC(38,0),
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