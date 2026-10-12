CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_updsel (itemid,
ziscurrentcontractfromsk, ziscurrentcontractfromsknew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.ziscurrentcontractfromsk,
 1 AS ziscurrentcontractfromsknew
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.itemsorting ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS stmara_eks_item_1 ON itemsorting.sortitemid =
  stmara_eks_item_1.itemid
WHERE stmara_eks_item.bitflag = 0
 AND stmara_eks_item_1.bitflag = 4
 AND stmara_eks_item_1.ziscurrentcontract = 1;