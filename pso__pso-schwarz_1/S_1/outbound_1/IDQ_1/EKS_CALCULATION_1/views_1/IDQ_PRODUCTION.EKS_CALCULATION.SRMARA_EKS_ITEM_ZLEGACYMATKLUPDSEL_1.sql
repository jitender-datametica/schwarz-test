CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zlegacymatklupdsel_1 (itemid, zlegacymatkl,
zlegacymatklnew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.zlegacymatkl,
 STEKS_ITEMGRPTIMELINE_PARENT.shortdesc AS zlegacymatklnew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.itemgroupitemrel_1 ON stmara_eks_item.itemid = itemgroupitemrel.itemid
 INNER JOIN idq_production_eks.itemgrptimeline_1 ON itemgroupitemrel.itemgroupid = itemgrptimeline.itemgroupid
 INNER JOIN idq_production_eks.itemgrptimeline_1 AS STEKS_ITEMGRPTIMELINE_PARENT ON itemgrptimeline.parentid =
  STEKS_ITEMGRPTIMELINE_PARENT.itemgroupid
 INNER JOIN (SELECT itemid,
   MAX(moddate) AS max_moddate
  FROM idq_production_eks.itemgroupitemrel_1
  GROUP BY itemid) AS ITEMGROUPITEMREL_MAXMODDATE ON itemgroupitemrel.itemid = ITEMGROUPITEMREL_MAXMODDATE.itemid AND
   itemgroupitemrel.moddate = ITEMGROUPITEMREL_MAXMODDATE.max_moddate
WHERE stmara_eks_item.zlegacymatkl IS NULL
 AND CAST(CURRENT_DATE AS DATETIME) BETWEEN itemgroupitemrel.datefrom AND itemgroupitemrel.dateuntil
 AND CAST(CURRENT_DATE AS DATETIME) BETWEEN itemgrptimeline.datefrom AND itemgrptimeline.dateuntil
 AND CAST(CURRENT_DATE AS DATETIME) BETWEEN STEKS_ITEMGRPTIMELINE_PARENT.datefrom AND STEKS_ITEMGRPTIMELINE_PARENT.dateuntil;