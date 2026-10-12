CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationeaba_updsel (itemid
, zactive, zactivenew, zisrelevantbyassociation, zisrelevantbyassociationnew) AS SELECT DISTINCT stmara_eks_item_1.itemid
 ,
 stmara_eks_item_1.zactive,
 stmara_eks_item.zactive AS zactivenew,
 stmara_eks_item_1.zisrelevantbyassociation,
 1 AS zisrelevantbyassociationnew
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.itemsorting ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS stmara_eks_item_1 ON itemsorting.sortitemid =
  stmara_eks_item_1.itemid
WHERE stmara_eks_item.bitflag = 0
 AND stmara_eks_item_1.bitflag = 2
 AND stmara_eks_item.zactive = 1
 AND stmara_eks_item.ziscurrentcontract = 1
 AND IFNULL(stmara_eks_item_1.zforcenotrelevant, 0) = 0;