CREATE OR REPLACE TABLE idq_production_eks.loheading (
loheadingid INTEGER NOT NULL,
nisflag BIGNUMERIC(38,0),
visibleflag_int BIGNUMERIC(38,0),
descriptionid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
dmsgroupid BIGNUMERIC(30,0),
PRIMARY KEY (loheadingid) NOT ENFORCED
);