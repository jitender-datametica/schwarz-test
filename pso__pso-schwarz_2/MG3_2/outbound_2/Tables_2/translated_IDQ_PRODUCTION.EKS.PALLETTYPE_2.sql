CREATE OR REPLACE TABLE idq_production_eks.pallettype_2 (
pallettypeid INTEGER NOT NULL,
deactive INTEGER,
visibleflag_number INTEGER,
descriptionid INTEGER,
shortdescid INTEGER,
palletkindid INTEGER,
pallettypefactorid INTEGER,
pallettypeproducerid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
mdsid STRING(64),
PRIMARY KEY (pallettypeid) NOT ENFORCED
);