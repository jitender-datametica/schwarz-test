CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_articlefamily_010_2 (zitem_ba, articlefamily) AS
SELECT stmara_eks_item.zitem_ba,
 MAX(IFNULL(STEKS_ITEMGRPTIMELINE_PARENT.shortdesc || '.' || itemgrptimeline.shortdesc, '')) AS articlefamily
FROM idq_production_eks.itemgrptimeline_2
 INNER JOIN idq_production_eks.itemgroupitemrel_2 ON itemgrptimeline.itemgroupid = itemgroupitemrel.itemgroupid
 INNER JOIN idq_production_eks.itemgrptimeline_2 AS STEKS_ITEMGRPTIMELINE_PARENT ON itemgrptimeline.parentid =
     STEKS_ITEMGRPTIMELINE_PARENT.itemgroupid AND CURRENT_DATE BETWEEN CAST(itemgroupitemrel.datefrom AS DATE) AND (CAST(itemgroupitemrel.dateuntil AS DATE)
      ) AND CURRENT_DATE BETWEEN CAST(itemgrptimeline.datefrom AS DATE) AND (CAST(itemgrptimeline.dateuntil AS DATE))
  AND CURRENT_DATE BETWEEN CAST(STEKS_ITEMGRPTIMELINE_PARENT.datefrom AS DATE) AND (CAST(STEKS_ITEMGRPTIMELINE_PARENT.dateuntil AS DATE)
    )
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 ON itemgroupitemrel.itemid = stmara_eks_item.itemid
WHERE stmara_eks_item.bitflag = 0
 AND stmara_eks_item.zactive = 1
GROUP BY stmara_eks_item.zitem_ba
HAVING COUNT(DISTINCT IFNULL(STEKS_ITEMGRPTIMELINE_PARENT.shortdesc || '.' || (REPEAT('0', 3 - LENGTH(itemgrptimeline.shortdesc
         )) || itemgrptimeline.shortdesc), '')) = 1;