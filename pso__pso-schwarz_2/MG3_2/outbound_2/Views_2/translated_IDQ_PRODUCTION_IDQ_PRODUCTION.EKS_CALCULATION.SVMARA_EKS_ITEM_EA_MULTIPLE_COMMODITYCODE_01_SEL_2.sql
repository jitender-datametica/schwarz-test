CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_ea_multiple_commoditycode_01_sel_2 (expr2, itemid)
AS SELECT COUNT(DISTINCT itemintrastat.intrastat) AS expr2,
 stmara_eks_item.itemid
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itemintrastat_2 ON stmara_eks_item.itemid = itemintrastat.itemid
GROUP BY stmara_eks_item.itemid
HAVING expr2 > 1;