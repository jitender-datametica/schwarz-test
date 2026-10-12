CREATE OR REPLACE TABLE idq_production_eks_calculation.stwrf_matgrp_sku_eks_item (
itemid BIGNUMERIC(38,0) NOT NULL,
bitflag BIGNUMERIC(38,0),
zlegacynode STRING(50),
znode STRING(18),
constructed NUMERIC(1,0),
constructedfrom STRING(255)
);