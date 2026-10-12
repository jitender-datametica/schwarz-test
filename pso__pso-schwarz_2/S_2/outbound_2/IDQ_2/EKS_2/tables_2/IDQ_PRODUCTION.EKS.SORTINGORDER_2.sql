CREATE OR REPLACE TABLE idq_production_eks.sortingorder_2 (
sortingorderid INTEGER NOT NULL,
position INTEGER,
moddate DATETIME,
crdate DATETIME,
moduser STRING(35),
cruser STRING(80),
locationid INTEGER,
competitorid INTEGER,
sortingtypeid INTEGER,
PRIMARY KEY (sortingorderid) NOT ENFORCED
);