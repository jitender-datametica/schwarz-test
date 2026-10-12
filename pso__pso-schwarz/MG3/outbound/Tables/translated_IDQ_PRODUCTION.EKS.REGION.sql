CREATE OR REPLACE TABLE idq_production_eks.region (
regionid INTEGER NOT NULL,
visibleflag INTEGER,
parentid INTEGER,
countryid INTEGER,
crdate DATETIME,
moddate DATETIME,
shortdesc STRING(25),
cruser STRING(35),
moduser STRING(35),
description STRING(80),
mdsid STRING(64),
PRIMARY KEY (regionid) NOT ENFORCED
);