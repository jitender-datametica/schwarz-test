CREATE OR REPLACE TABLE idq_production_eks.zertification_2 (
zertificationid BIGNUMERIC(38,0),
supplierstationid BIGNUMERIC(38,0),
zertificationgroupid BIGNUMERIC(38,0),
datefrom STRING(40),
dateuntil STRING(40),
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
identification BIGNUMERIC(38,0),
zertificationtypeid BIGNUMERIC(38,0),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);