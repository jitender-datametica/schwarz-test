CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_differentbaseuom_01_2 (zitem_ba) AS SELECT zitem_ba
FROM idq_production_eks_calculation.stmara_eks_item_2
WHERE zarticletype = 'EA'
 AND zactive = 1
GROUP BY zitem_ba
HAVING MIN(zmeins) <> MAX(zmeins);