CREATE OR REPLACE TABLE idq_production_eks_calculation.steks_listingoverviewmax (
listingoverviewid BIGNUMERIC(38,0) NOT NULL,
location STRING(5),
supplierno BIGNUMERIC(38,0),
cr_locationid BIGNUMERIC(38,0),
receivingcountry STRING(5),
itemid BIGNUMERIC(38,0),
casesize BIGNUMERIC(38,0),
zitem_ba BIGNUMERIC(38,0),
zarticletype STRING(2),
zactive BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
);