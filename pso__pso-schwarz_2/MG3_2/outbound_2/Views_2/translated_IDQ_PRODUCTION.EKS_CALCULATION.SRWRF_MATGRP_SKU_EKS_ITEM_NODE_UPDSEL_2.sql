CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_node_updsel_2 (itemid, znodenew, znode,
zlegacynode) AS SELECT DISTINCT stwrf_matgrp_sku_eks_item.itemid,
 wrf_matgrp_strct.node AS znodenew,
 stwrf_matgrp_sku_eks_item.znode,
 stwrf_matgrp_sku_eks_item.zlegacynode
FROM idq_production_zsm.wrf_matgrp_strct_2
 INNER JOIN idq_production_eks_calculation.stwrf_matgrp_sku_eks_item_2 ON CAST(SUBSTR(wrf_matgrp_strct.ltext, 1, STRPOS(wrf_matgrp_strct.ltext, ' ') - 1) AS STRING)
  = stwrf_matgrp_sku_eks_item.zlegacynode
WHERE wrf_matgrp_strct.spras = 'D'
 AND stwrf_matgrp_sku_eks_item.zlegacynode IS NOT NULL
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(stwrf_matgrp_sku_eks_item.itemid AS STRING) ORDER BY znodenew IS NULL,
      znodenew)) = 1;