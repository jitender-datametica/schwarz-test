CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_constructed_updsel_2 (itemid,
zlegacynode, zlegacynodenew) AS SELECT DISTINCT stwrf_matgrp_sku_eks_item.itemid,
 stwrf_matgrp_sku_eks_item.zlegacynode,
 ea.zlegacynode AS zlegacynodenew
FROM idq_production_eks_calculation.stwrf_matgrp_sku_eks_item_2
 INNER JOIN idq_production_eks_calculation.stwrf_matgrp_sku_eks_item_2 AS ea ON CAST(stwrf_matgrp_sku_eks_item.constructedfrom AS FLOAT64)
  = ea.itemid
WHERE stwrf_matgrp_sku_eks_item.constructed = 1;