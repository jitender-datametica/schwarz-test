CREATE OR REPLACE VIEW idq_production_eks_calculation.srwrf_matgrp_sku_eks_item_zlegacynode_01_2 (zitem_ba, zlegacynode)
AS SELECT stmara_eks_item.zitem_ba,
 MAX(IFNULL(STEKS_ITEMGRPTIMELINE_PARENT.shortdesc || '.' || (REPEAT('0', 3 - LENGTH(itemgrptimeline.shortdesc)) ||
      itemgrptimeline.shortdesc), '')) AS zlegacynode
FROM idq_production_eks.itemgrptimeline_2
 INNER JOIN idq_production_eks.itemgroupitemrel_2 ON itemgrptimeline.itemgroupid = itemgroupitemrel.itemgroupid
 INNER JOIN idq_production_eks.itemgrptimeline_2 AS STEKS_ITEMGRPTIMELINE_PARENT ON itemgrptimeline.parentid =
     STEKS_ITEMGRPTIMELINE_PARENT.itemgroupid AND CURRENT_TIMESTAMP() BETWEEN CAST(itemgroupitemrel.datefrom AS TIMESTAMP)
     AND (CAST(itemgroupitemrel.dateuntil AS TIMESTAMP)) AND CURRENT_TIMESTAMP() BETWEEN CAST(itemgrptimeline.datefrom AS TIMESTAMP)
    AND (CAST(itemgrptimeline.dateuntil AS TIMESTAMP)) AND CURRENT_TIMESTAMP() BETWEEN CAST(STEKS_ITEMGRPTIMELINE_PARENT.datefrom AS TIMESTAMP)
   AND (CAST(STEKS_ITEMGRPTIMELINE_PARENT.dateuntil AS TIMESTAMP))
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 ON itemgroupitemrel.itemid = stmara_eks_item.itemid
WHERE stmara_eks_item.bitflag = 0
 AND stmara_eks_item.zactive = 1
GROUP BY stmara_eks_item.zitem_ba
HAVING COUNT(DISTINCT IFNULL(STEKS_ITEMGRPTIMELINE_PARENT.shortdesc || '.' || (REPEAT('0', 3 - LENGTH(itemgrptimeline.shortdesc
         )) || itemgrptimeline.shortdesc), '')) = 1;