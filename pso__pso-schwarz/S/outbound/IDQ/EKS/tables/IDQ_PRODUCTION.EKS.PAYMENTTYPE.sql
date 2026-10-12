CREATE OR REPLACE TABLE idq_production_eks.paymenttype (
paymenttypeid BIGNUMERIC(38,0),
inactive BIGNUMERIC(38,0),
visibleflag_int BIGNUMERIC(38,0),
position BIGNUMERIC(38,0),
descriptionid BIGNUMERIC(38,0),
shortdescid BIGNUMERIC(38,0),
paymenttypegroupid BIGNUMERIC(30,0),
crdate STRING(40),
moddate STRING(40),
cruser STRING(35),
moduser STRING(35),
country_code STRING(2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);