CREATE OR REPLACE TABLE idq_production_eks.region_2 (
regionid BIGNUMERIC(38,0) NOT NULL,
visibleflag BIGNUMERIC(38,0),
parentid BIGNUMERIC(38,0),
countryid BIGNUMERIC(38,0),
crdate DATETIME,
moddate DATETIME,
shortdesc STRING(25),
cruser STRING(35),
moduser STRING(35),
description STRING(80),
mdsid STRING(64),
PRIMARY KEY (regionid) NOT ENFORCED
);