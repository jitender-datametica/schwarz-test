CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zisskhasbaupdsel (itemid, zisskhasba,
zisskhasbanew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.zisskhasba,
 '1' AS zisskhasbanew
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.itemsorting ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS steks_item_parent ON itemsorting.sortitemid =
  steks_item_parent.itemid
WHERE stmara_eks_item.zisskhasba IS NULL
 AND stmara_eks_item.bitflag = 4
 AND steks_item_parent.bitflag = 2;