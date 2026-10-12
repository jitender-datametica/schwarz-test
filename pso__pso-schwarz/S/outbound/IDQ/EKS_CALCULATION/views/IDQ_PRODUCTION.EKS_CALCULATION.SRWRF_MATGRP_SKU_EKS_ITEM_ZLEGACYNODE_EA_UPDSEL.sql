CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_ea_updsel (itemid, level_1,
level_2, zlegacynode, zlegacynodenew) AS SELECT DISTINCT stwrf_matgrp_sku_eks_item.itemid,
 itemgrptimeline.shortdesc AS level_1,
 STEKS_ITEMGRPTIMELINE_PARENT.shortdesc AS level_2,
 stwrf_matgrp_sku_eks_item.zlegacynode,
 IFNULL(STEKS_ITEMGRPTIMELINE_PARENT.shortdesc || '.' || (REPEAT('0', 3 - LENGTH(itemgrptimeline.shortdesc)) ||
     itemgrptimeline.shortdesc), '') AS zlegacynodenew
FROM idq_production_eks.itemgrptimeline
 INNER JOIN idq_production_eks.itemgroupitemrel ON itemgrptimeline.itemgroupid = itemgroupitemrel.itemgroupid
 INNER JOIN idq_production_eks.itemgrptimeline AS STEKS_ITEMGRPTIMELINE_PARENT ON itemgrptimeline.parentid =
  STEKS_ITEMGRPTIMELINE_PARENT.itemgroupid
 RIGHT JOIN idq_production_eks_calculation.stwrf_matgrp_sku_eks_item ON itemgroupitemrel.itemid =
     stwrf_matgrp_sku_eks_item.itemid AND CURRENT_TIMESTAMP() BETWEEN CAST(itemgroupitemrel.datefrom AS TIMESTAMP)
     AND (CAST(itemgroupitemrel.dateuntil AS TIMESTAMP)) AND CURRENT_TIMESTAMP() BETWEEN CAST(itemgrptimeline.datefrom AS TIMESTAMP)
    AND (CAST(itemgrptimeline.dateuntil AS TIMESTAMP)) AND CURRENT_TIMESTAMP() BETWEEN CAST(STEKS_ITEMGRPTIMELINE_PARENT.datefrom AS TIMESTAMP)
   AND (CAST(STEKS_ITEMGRPTIMELINE_PARENT.dateuntil AS TIMESTAMP))
WHERE stwrf_matgrp_sku_eks_item.constructed IS NULL
 AND stwrf_matgrp_sku_eks_item.bitflag = 0
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(stwrf_matgrp_sku_eks_item.itemid AS STRING) ORDER BY zlegacynodenew
      IS NULL, zlegacynodenew)) = 1;