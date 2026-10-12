CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_articlefamily_bask_updsel (itemid, articlefamily,
articlefamilynew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.articlefamily,
 IFNULL(srmara_eks_item_articlefamily_010.articlefamily, '') AS articlefamilynew
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_articlefamily_010 ON stmara_eks_item.zitem_ba =
  srmara_eks_item_articlefamily_010.zitem_ba
WHERE stmara_eks_item.constructed IS NULL
 AND stmara_eks_item.articlefamily IS NULL
 AND stmara_eks_item.bitflag IN (2, 4);