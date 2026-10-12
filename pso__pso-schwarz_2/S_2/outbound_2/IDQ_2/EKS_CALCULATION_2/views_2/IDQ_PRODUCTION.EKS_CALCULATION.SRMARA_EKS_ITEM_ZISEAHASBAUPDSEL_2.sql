CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziseahasbaupdsel_2 (itemid, ziseahasba,
ziseahasbanew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.ziseahasba,
 '1' AS ziseahasbanew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itemsorting_2 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks.item_2 AS ITEM_PARENT ON itemsorting.sortitemid = ITEM_PARENT.itemid
WHERE stmara_eks_item.ziseahasba IS NULL
 AND stmara_eks_item.bitflag = 0
 AND ITEM_PARENT.bitflag = 2;