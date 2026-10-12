CREATE OR REPLACE TABLE idq_production_eks.package (
packageid INTEGER NOT NULL,
visibleflag INTEGER,
descriptionid INTEGER,
shortdescid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
mdsid STRING(64),
PRIMARY KEY (packageid) NOT ENFORCED
);