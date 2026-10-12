CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_constructbaskfrommara_inssel_2 (itemid,
bitflag, constructed, constructedfrom) AS SELECT itemid,
 bitflag,
 constructed,
 constructedfrom
FROM idq_production_eks_calculation.stmara_eks_item_2
WHERE constructed = 1;