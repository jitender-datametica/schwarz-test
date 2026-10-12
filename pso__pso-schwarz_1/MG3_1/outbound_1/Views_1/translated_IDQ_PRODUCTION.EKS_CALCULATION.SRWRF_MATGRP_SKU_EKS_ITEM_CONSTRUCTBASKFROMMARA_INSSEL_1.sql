CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_inssel_1 (itemid,
bitflag, constructed, constructedfrom) AS SELECT itemid,
 bitflag,
 constructed,
 constructedfrom
FROM idq_production_eks_calculation.stmara_eks_item_1
WHERE constructed = 1;