CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontractfromsk_updsel_1 (itemid
, ziscurrentcontractfromsk, ziscurrentcontractfromsknew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.ziscurrentcontractfromsk,
 1 AS ziscurrentcontractfromsknew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.itemsorting_1 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_eks_item_1 ON itemsorting.sortitemid =
  stmara_eks_item_1.itemid
WHERE stmara_eks_item.bitflag = 0
 AND stmara_eks_item_1.bitflag = 4
 AND stmara_eks_item.ziscurrentcontractfromsk IS NULL
 AND stmara_eks_item_1.ziscurrentcontract = 1
 AND stmara_eks_item_1.zrelevantmdm = 1;