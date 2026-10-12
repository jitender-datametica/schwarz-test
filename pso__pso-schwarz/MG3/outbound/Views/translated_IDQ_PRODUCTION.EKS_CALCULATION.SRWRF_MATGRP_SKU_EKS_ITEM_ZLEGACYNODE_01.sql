CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_01 (zitem_ba, zlegacynode)
AS SELECT stmara_eks_item.zitem_ba,
 MAX(IFNULL(steks_itemgrptimeline_parent.shortdesc || '.' || (REPEAT('0', 3 - LENGTH(itemgrptimeline.shortdesc)) ||
      itemgrptimeline.shortdesc), '')) AS zlegacynode
FROM idq_production_eks.itemgrptimeline
 INNER JOIN idq_production_eks.itemgroupitemrel ON itemgrptimeline.itemgroupid = itemgroupitemrel.itemgroupid
 INNER JOIN idq_production_eks.itemgrptimeline AS steks_itemgrptimeline_parent ON itemgrptimeline.parentid =
     steks_itemgrptimeline_parent.itemgroupid AND CURRENT_TIMESTAMP() BETWEEN CAST(itemgroupitemrel.datefrom AS TIMESTAMP)
     AND (CAST(itemgroupitemrel.dateuntil AS TIMESTAMP)) AND CURRENT_TIMESTAMP() BETWEEN CAST(itemgrptimeline.datefrom AS TIMESTAMP)
    AND (CAST(itemgrptimeline.dateuntil AS TIMESTAMP)) AND CURRENT_TIMESTAMP() BETWEEN CAST(steks_itemgrptimeline_parent.datefrom AS TIMESTAMP)
   AND (CAST(steks_itemgrptimeline_parent.dateuntil AS TIMESTAMP))
 INNER JOIN idq_production_eks_calculation.stmara_eks_item ON itemgroupitemrel.itemid = stmara_eks_item.itemid
WHERE stmara_eks_item.bitflag = 0
 AND stmara_eks_item.zactive = 1
GROUP BY stmara_eks_item.zitem_ba
HAVING COUNT(DISTINCT IFNULL(steks_itemgrptimeline_parent.shortdesc || '.' || (REPEAT('0', 3 - LENGTH(itemgrptimeline.shortdesc
         )) || itemgrptimeline.shortdesc), '')) = 1;