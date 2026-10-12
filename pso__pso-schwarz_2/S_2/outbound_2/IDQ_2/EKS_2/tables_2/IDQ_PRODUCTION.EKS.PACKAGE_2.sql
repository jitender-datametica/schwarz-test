CREATE OR REPLACE TABLE idq_production_eks.package_2 (
packageid BIGNUMERIC(38,0) NOT NULL,
visibleflag BIGNUMERIC(38,0),
descriptionid INTEGER,
shortdescid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
mdsid STRING(64),
PRIMARY KEY (packageid) NOT ENFORCED
);