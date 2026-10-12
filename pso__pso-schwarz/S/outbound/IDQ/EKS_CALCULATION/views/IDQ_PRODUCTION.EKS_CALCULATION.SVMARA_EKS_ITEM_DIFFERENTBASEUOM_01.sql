CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_differentbaseuom_01 (zitem_ba) AS SELECT zitem_ba
FROM idq_production_eks_calculation.stmara_eks_item
WHERE zarticletype = 'EA'
 AND zactive = 1
GROUP BY zitem_ba
HAVING MIN(zmeins) <> MAX(zmeins);