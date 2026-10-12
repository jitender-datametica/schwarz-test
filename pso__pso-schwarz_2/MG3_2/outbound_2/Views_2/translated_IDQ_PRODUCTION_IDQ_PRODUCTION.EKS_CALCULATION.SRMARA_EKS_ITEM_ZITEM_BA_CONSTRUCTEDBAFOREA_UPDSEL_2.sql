CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zitem_ba_constructedbaforea_updsel_2 (itemid,
zitem_banew, zitem_ba) AS SELECT stmara_eks_item_1.itemid,
 stmara_eks_item.itemid AS zitem_banew,
 stmara_eks_item_1.zitem_ba
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS stmara_eks_item_1 ON CAST(stmara_eks_item.constructedfrom AS FLOAT64)
  = stmara_eks_item_1.itemid
WHERE stmara_eks_item.zarticletype = 'BA'
 AND stmara_eks_item.constructed = 1
 AND stmara_eks_item_1.zarticletype = 'EA';