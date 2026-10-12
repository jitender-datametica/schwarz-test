CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_constructed_updsel (itemid,
zlegacynode, zlegacynodenew) AS SELECT DISTINCT stwrf_matgrp_sku_eks_item.itemid,
 stwrf_matgrp_sku_eks_item.zlegacynode,
 EA.zlegacynode AS zlegacynodenew
FROM idq_production_eks_calculation.stwrf_matgrp_sku_eks_item
 INNER JOIN idq_production_eks_calculation.stwrf_matgrp_sku_eks_item AS EA ON CAST(stwrf_matgrp_sku_eks_item.constructedfrom AS FLOAT64)
  = EA.itemid
WHERE stwrf_matgrp_sku_eks_item.constructed = 1;