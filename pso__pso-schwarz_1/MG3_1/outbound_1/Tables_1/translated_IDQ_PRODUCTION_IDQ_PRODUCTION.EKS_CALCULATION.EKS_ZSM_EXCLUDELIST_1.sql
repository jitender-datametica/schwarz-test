CREATE OR REPLACE TABLE idq_production_eks_calculation.eks_zsm_excludelist_1 (
id INTEGER NOT NULL,
zsource STRING(50),
itemid INTEGER,
itemno INTEGER NOT NULL,
negotiatingcountry STRING(5),
articletype STRING(2),
supplierno INTEGER,
listingoverviewid INTEGER,
reportno STRING(5) NOT NULL,
comment STRING(255),
addedby STRING(50),
addedon DATETIME,
addedvia STRING(50),
changedby STRING(50),
changedon DATETIME,
changedvia STRING(50),
boastatus INTEGER
);