CREATE OR REPLACE TABLE idq_production_eks_calculation.eks_zsm_articlerelevancyoverride_1 (
zsource STRING(50),
negotiatingcountry STRING(3),
itemno STRING(50) NOT NULL,
forcerelevant INTEGER,
forcenotrelevant INTEGER,
addedby STRING(50),
addedon DATETIME,
addedvia STRING(50),
changedby STRING(50),
changedon DATETIME,
changedvia STRING(50),
boastatus INTEGER
);