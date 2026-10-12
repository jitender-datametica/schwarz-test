CREATE OR REPLACE TABLE idq_production_eks.pallettype_2 (
pallettypeid BIGNUMERIC(38,0) NOT NULL,
deactive BIGNUMERIC(38,0),
visibleflag_number BIGNUMERIC(38,0),
descriptionid INTEGER,
shortdescid INTEGER,
palletkindid BIGNUMERIC(30,0),
pallettypefactorid BIGNUMERIC(30,0),
pallettypeproducerid BIGNUMERIC(30,0),
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
mdsid STRING(64),
PRIMARY KEY (pallettypeid) NOT ENFORCED
);