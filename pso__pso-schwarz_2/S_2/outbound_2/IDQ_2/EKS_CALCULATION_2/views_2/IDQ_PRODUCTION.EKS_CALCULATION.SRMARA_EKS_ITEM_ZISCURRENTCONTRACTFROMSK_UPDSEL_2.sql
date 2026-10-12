CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_updsel_2 (itemid,
ziscurrentcontractfromsk, ziscurrentcontractfromsknew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.ziscurrentcontractfromsk,
 1 AS ziscurrentcontractfromsknew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itemsorting_2 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS STMARA_EKS_ITEM_1 ON itemsorting.sortitemid =
  STMARA_EKS_ITEM_1.itemid
WHERE stmara_eks_item.bitflag = 0
 AND STMARA_EKS_ITEM_1.bitflag = 4
 AND STMARA_EKS_ITEM_1.ziscurrentcontract = 1;