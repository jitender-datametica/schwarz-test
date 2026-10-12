CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_bask_updsel_2 (itemid,
zlegacynode, zlegacynodenew) AS SELECT DISTINCT stwrf_matgrp_sku_eks_item.itemid,
 stwrf_matgrp_sku_eks_item.zlegacynode,
 IFNULL(srwrf_matgrp_sku_eks_item_zlegacynode_01.zlegacynode, '') AS zlegacynodenew
FROM idq_production_eks_calculation.stwrf_matgrp_sku_eks_item_2
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 ON stwrf_matgrp_sku_eks_item.itemid = stmara_eks_item.itemid
 LEFT JOIN idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_01_2 ON stmara_eks_item.zitem_ba =
  srwrf_matgrp_sku_eks_item_zlegacynode_01.zitem_ba
WHERE stwrf_matgrp_sku_eks_item.constructed IS NULL
 AND stwrf_matgrp_sku_eks_item.zlegacynode IS NULL
 AND stwrf_matgrp_sku_eks_item.bitflag IN (2, 4);