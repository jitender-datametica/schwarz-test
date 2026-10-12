CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zisskhasbaupdsel_1 (itemid, zisskhasba,
zisskhasbanew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.zisskhasba,
 '1' AS zisskhasbanew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.itemsorting_1 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS STEKS_ITEM_PARENT ON itemsorting.sortitemid =
  STEKS_ITEM_PARENT.itemid
WHERE stmara_eks_item.zisskhasba IS NULL
 AND stmara_eks_item.bitflag = 4
 AND STEKS_ITEM_PARENT.bitflag = 2;