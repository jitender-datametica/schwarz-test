CREATE OR REPLACE TABLE idq_production_eks.loheading (
loheadingid INTEGER NOT NULL,
nisflag INTEGER,
visibleflag_int INTEGER,
descriptionid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
dmsgroupid INTEGER,
PRIMARY KEY (loheadingid) NOT ENFORCED
);