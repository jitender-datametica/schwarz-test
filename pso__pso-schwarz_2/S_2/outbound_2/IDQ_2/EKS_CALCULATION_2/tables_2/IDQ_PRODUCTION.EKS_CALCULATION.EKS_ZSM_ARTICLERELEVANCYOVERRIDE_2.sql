CREATE OR REPLACE TABLE idq_production_eks_calculation.eks_zsm_articlerelevancyoverride_2 (
zsource STRING(50),
negotiatingcountry STRING(3),
itemno STRING(50) NOT NULL,
forcerelevant BIGNUMERIC(38,0),
forcenotrelevant BIGNUMERIC(38,0),
addedby STRING(50),
addedon DATETIME,
addedvia STRING(50),
changedby STRING(50),
changedon DATETIME,
changedvia STRING(50),
boastatus BIGNUMERIC(38,0)
);