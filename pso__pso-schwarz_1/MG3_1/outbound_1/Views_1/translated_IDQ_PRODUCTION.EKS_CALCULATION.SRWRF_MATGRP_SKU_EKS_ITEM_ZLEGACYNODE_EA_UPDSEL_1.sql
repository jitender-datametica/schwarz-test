CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_ea_updsel_1 (itemid, level_1,
level_2, zlegacynode, zlegacynodenew) AS SELECT DISTINCT stwrf_matgrp_sku_eks_item.itemid,
 itemgrptimeline.shortdesc AS level_1,
 steks_itemgrptimeline_parent.shortdesc AS level_2,
 stwrf_matgrp_sku_eks_item.zlegacynode,
 IFNULL(steks_itemgrptimeline_parent.shortdesc || '.' || (REPEAT('0', 3 - LENGTH(itemgrptimeline.shortdesc)) ||
     itemgrptimeline.shortdesc), '') AS zlegacynodenew
FROM idq_production_eks.itemgrptimeline_1
 INNER JOIN idq_production_eks.itemgroupitemrel_1 ON itemgrptimeline.itemgroupid = itemgroupitemrel.itemgroupid
 INNER JOIN idq_production_eks.itemgrptimeline_1 AS steks_itemgrptimeline_parent ON itemgrptimeline.parentid =
  steks_itemgrptimeline_parent.itemgroupid
 RIGHT JOIN idq_production_eks_calculation.stwrf_matgrp_sku_eks_item_1 ON itemgroupitemrel.itemid =
     stwrf_matgrp_sku_eks_item.itemid AND CURRENT_TIMESTAMP() BETWEEN CAST(itemgroupitemrel.datefrom AS TIMESTAMP)
     AND (CAST(itemgroupitemrel.dateuntil AS TIMESTAMP)) AND CURRENT_TIMESTAMP() BETWEEN CAST(itemgrptimeline.datefrom AS TIMESTAMP)
    AND (CAST(itemgrptimeline.dateuntil AS TIMESTAMP)) AND CURRENT_TIMESTAMP() BETWEEN CAST(steks_itemgrptimeline_parent.datefrom AS TIMESTAMP)
   AND (CAST(steks_itemgrptimeline_parent.dateuntil AS TIMESTAMP))
WHERE stwrf_matgrp_sku_eks_item.constructed IS NULL
 AND stwrf_matgrp_sku_eks_item.bitflag = 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(stwrf_matgrp_sku_eks_item.itemid AS STRING) ORDER BY zlegacynodenew
      IS NULL, zlegacynodenew)) = 1;