CREATE OR REPLACE TABLE idq_production_eks.signspecval (
signspecvalid BIGNUMERIC(38,0),
signspecid BIGNUMERIC(38,0),
defaultflag BIGNUMERIC(38,0),
gen_rv BIGNUMERIC(38,0),
visibleflag BIGNUMERIC(38,0),
visibleflag_int BIGNUMERIC(38,0),
descriptionid INTEGER,
shortdescid INTEGER,
crdate DATETIME,
moddate DATETIME,
cruser STRING(35),
moduser STRING(35),
dmsgroupid BIGNUMERIC(38,0)
);