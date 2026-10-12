CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zactive_zisrelevantbyassociationskba_updsel_1 (itemid
, zactive, zactivenew, zisrelevantbyassociation, zisrelevantbyassociationnew) AS SELECT DISTINCT STMARA_EKS_ITEM_1.itemid
 ,
 STMARA_EKS_ITEM_1.zactive,
 stmara_eks_item.zactive AS zactivenew,
 STMARA_EKS_ITEM_1.zisrelevantbyassociation,
 1 AS zisrelevantbyassociationnew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.itemsorting_1 ON stmara_eks_item.itemid = itemsorting.itemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS STMARA_EKS_ITEM_1 ON itemsorting.sortitemid =
  STMARA_EKS_ITEM_1.itemid
WHERE stmara_eks_item.bitflag = 4
 AND STMARA_EKS_ITEM_1.bitflag = 2
 AND stmara_eks_item.zactive = 1
 AND IFNULL(STMARA_EKS_ITEM_1.zforcenotrelevant, 0) = 0;