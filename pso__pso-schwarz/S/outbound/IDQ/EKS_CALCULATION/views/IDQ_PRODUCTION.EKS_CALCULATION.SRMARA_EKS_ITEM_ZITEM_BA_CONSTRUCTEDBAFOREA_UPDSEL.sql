CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zitem_ba_constructedbaforea_updsel (itemid,
zitem_banew, zitem_ba) AS SELECT STMARA_EKS_ITEM_1.itemid,
 stmara_eks_item.itemid AS zitem_banew,
 STMARA_EKS_ITEM_1.zitem_ba
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS STMARA_EKS_ITEM_1 ON CAST(stmara_eks_item.constructedfrom AS FLOAT64)
  = STMARA_EKS_ITEM_1.itemid
WHERE stmara_eks_item.zarticletype = 'BA'
 AND stmara_eks_item.constructed = 1
 AND STMARA_EKS_ITEM_1.zarticletype = 'EA';