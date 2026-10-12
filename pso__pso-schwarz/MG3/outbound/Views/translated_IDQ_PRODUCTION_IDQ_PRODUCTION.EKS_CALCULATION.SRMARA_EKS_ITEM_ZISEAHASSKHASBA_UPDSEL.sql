CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziseahasskhasba_updsel (itemid, ziseahasskhasbanew
, ziseahasskhasba) AS SELECT DISTINCT t1.itemid,
 1 AS ziseahasskhasbanew,
 t1.ziseahasskhasba
FROM idq_production_eks_calculation.stmara_eks_item AS t1
 INNER JOIN idq_production_eks.itemsorting AS t2 ON t1.itemid = t2.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS t3 ON t2.sortitemid = t3.itemid
 INNER JOIN idq_production_eks.itemsorting AS t4 ON t3.itemid = t4.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS t5 ON t4.sortitemid = t5.itemid
WHERE t1.bitflag = 0
 AND t3.bitflag = 4
 AND t5.bitflag = 2
 AND t1.ziseahasskhasba IS NULL;