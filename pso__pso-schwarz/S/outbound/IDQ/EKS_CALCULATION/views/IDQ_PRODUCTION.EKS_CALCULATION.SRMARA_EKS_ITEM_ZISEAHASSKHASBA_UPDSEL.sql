CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziseahasskhasba_updsel (itemid, ziseahasskhasbanew
, ziseahasskhasba) AS SELECT DISTINCT T1.itemid,
 1 AS ziseahasskhasbanew,
 T1.ziseahasskhasba
FROM idq_production_eks_calculation.stmara_eks_item AS T1
 INNER JOIN idq_production_eks.itemsorting AS T2 ON T1.itemid = T2.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS T3 ON T2.sortitemid = T3.itemid
 INNER JOIN idq_production_eks.itemsorting AS T4 ON T3.itemid = T4.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS T5 ON T4.sortitemid = T5.itemid
WHERE T1.bitflag = 0
 AND T3.bitflag = 4
 AND T5.bitflag = 2
 AND T1.ziseahasskhasba IS NULL;