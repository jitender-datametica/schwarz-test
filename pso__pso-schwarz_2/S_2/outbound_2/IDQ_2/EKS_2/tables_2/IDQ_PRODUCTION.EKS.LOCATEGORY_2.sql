CREATE OR REPLACE TABLE idq_production_eks.locategory_2 (
locategoryid BIGNUMERIC(30,0) NOT NULL,
visibleflag_int BIGNUMERIC(38,0),
descriptionid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
PRIMARY KEY (locategoryid) NOT ENFORCED
);