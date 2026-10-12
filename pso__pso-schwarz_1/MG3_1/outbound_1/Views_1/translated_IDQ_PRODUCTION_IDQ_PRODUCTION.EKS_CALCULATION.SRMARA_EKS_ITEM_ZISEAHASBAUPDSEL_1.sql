CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziseahasbaupdsel_1 (itemid, ziseahasba,
ziseahasbanew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.ziseahasba,
 '1' AS ziseahasbanew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.itemsorting_1 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks.item_1 AS item_parent ON itemsorting.sortitemid = item_parent.itemid
WHERE stmara_eks_item.ziseahasba IS NULL
 AND stmara_eks_item.bitflag = 0
 AND item_parent.bitflag = 2;