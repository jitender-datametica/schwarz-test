CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_articlefamily_ea_updsel_1 (itemid, level_1, level_2
, articlefamily, articlefamilynew) AS SELECT DISTINCT stmara_eks_item.itemid,
 itemgrptimeline.shortdesc AS level_1,
 steks_itemgrptimeline_parent.shortdesc AS level_2,
 stmara_eks_item.articlefamily,
 IFNULL(steks_itemgrptimeline_parent.shortdesc || '.' || itemgrptimeline.shortdesc, '') AS articlefamilynew
FROM idq_production_eks.itemgrptimeline_1
 INNER JOIN idq_production_eks.itemgroupitemrel_1 ON itemgrptimeline.itemgroupid = itemgroupitemrel.itemgroupid
 INNER JOIN idq_production_eks.itemgrptimeline_1 AS steks_itemgrptimeline_parent ON itemgrptimeline.parentid =
  steks_itemgrptimeline_parent.itemgroupid
 INNER JOIN (SELECT itemid,
   MAX(moddate) AS max_moddate
  FROM idq_production_eks.itemgroupitemrel_1
  GROUP BY itemid) AS ITEMGROUPITEMREL_MAXMODDATE ON itemgroupitemrel.itemid = ITEMGROUPITEMREL_MAXMODDATE.itemid AND
   itemgroupitemrel.moddate = ITEMGROUPITEMREL_MAXMODDATE.max_moddate
 RIGHT JOIN idq_production_eks_calculation.stmara_eks_item_1 ON itemgroupitemrel.itemid = stmara_eks_item.itemid AND
     CURRENT_DATE BETWEEN CAST(itemgroupitemrel.datefrom AS DATE) AND (CAST(itemgroupitemrel.dateuntil AS DATE)) AND
    CURRENT_DATE BETWEEN CAST(itemgrptimeline.datefrom AS DATE) AND (CAST(itemgrptimeline.dateuntil AS DATE)) AND
   CURRENT_DATE BETWEEN CAST(steks_itemgrptimeline_parent.datefrom AS DATE) AND (CAST(steks_itemgrptimeline_parent.dateuntil AS DATE)
    )
WHERE stmara_eks_item.constructed IS NULL
 AND stmara_eks_item.bitflag = 0;