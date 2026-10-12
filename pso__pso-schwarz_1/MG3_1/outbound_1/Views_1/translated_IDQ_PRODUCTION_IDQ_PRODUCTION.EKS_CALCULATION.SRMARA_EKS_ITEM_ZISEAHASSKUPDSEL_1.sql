CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziseahasskupdsel_1 (itemid, ziseahassk,
ziseahassknew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.ziseahassk,
 '1' AS ziseahassknew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.itemsorting_1 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS steks_item_parent ON itemsorting.sortitemid =
  steks_item_parent.itemid
WHERE stmara_eks_item.ziseahassk IS NULL
 AND stmara_eks_item.bitflag = 0
 AND steks_item_parent.bitflag = 4;