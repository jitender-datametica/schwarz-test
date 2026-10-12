CREATE OR REPLACE TABLE idq_production_eks_calculation.eks_zsm_articleparameter_1 (
id STRING(20) NOT NULL,
parameterdescription STRING(50),
value NUMERIC(12,2),
addedby STRING(50),
addedon DATETIME,
addedvia STRING(50),
changedby STRING(50),
changedon DATETIME,
changedvia STRING(50),
boastatus BIGNUMERIC(38,0),
valueactive STRING(1),
date DATETIME,
dateactive STRING(1)
);