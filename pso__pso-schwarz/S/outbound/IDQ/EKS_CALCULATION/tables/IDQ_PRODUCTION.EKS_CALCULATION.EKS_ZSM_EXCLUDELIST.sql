CREATE OR REPLACE TABLE idq_production_eks_calculation.eks_zsm_excludelist (
id BIGNUMERIC(38,0) NOT NULL,
zsource STRING(50),
itemid BIGNUMERIC(38,0),
itemno BIGNUMERIC(38,0) NOT NULL,
negotiatingcountry STRING(5),
articletype STRING(2),
supplierno BIGNUMERIC(38,0),
listingoverviewid BIGNUMERIC(38,0),
reportno STRING(5) NOT NULL,
comment STRING(255),
addedby STRING(50),
addedon DATETIME,
addedvia STRING(50),
changedby STRING(50),
changedon DATETIME,
changedvia STRING(50),
boastatus BIGNUMERIC(38,0)
);