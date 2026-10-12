CREATE OR REPLACE TABLE idq_production_eks.communication (
commid INTEGER,
contactid INTEGER,
commtypeid INTEGER,
defaultflag INTEGER,
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
countrydialcode STRING(5),
citydialcode STRING(20),
dialnumber STRING(20),
dialcomment STRING(80),
email STRING(120),
sap_id STRING(15),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);