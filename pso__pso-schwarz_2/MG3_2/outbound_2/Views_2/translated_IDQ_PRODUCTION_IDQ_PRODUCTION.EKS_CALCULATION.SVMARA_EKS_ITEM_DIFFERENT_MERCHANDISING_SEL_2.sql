CREATE OR REPLACE VIEW idq_production_eks_calculation.svmara_eks_item_different_merchandising_sel_2 (zsource, zactive,
negotiatingcountry, itemid, itemno, articletype, description, merchandising_group, ba_item_no, buyerfirstname,
buyerlastname, buyershortsign) AS SELECT stmara_eks_item.zsource,
 stmara_eks_item.zactive,
 stmara_eks_item.znegotiatingcountry AS negotiatingcountry,
 stmara_eks_item.itemid,
 stmara_eks_item.itemno,
 stmara_eks_item.zarticletype AS articletype,
 stmara_eks_item.description_int AS description,
 stmara_eks_item.zlegacymatkl AS merchandising_group,
 stmara_eks_item_1.itemno AS ba_item_no,
 stmara_eks_item.buyerfirstname,
 stmara_eks_item.buyerlastname,
 stmara_eks_item.buyershortsign
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks_calculation.svmara_eks_item_merchandising_02_sel_2 ON stmara_eks_item.zitem_ba =
  svmara_eks_item_merchandising_02_sel.baitemnumber
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_2 AS stmara_eks_item_1 ON stmara_eks_item.zitem_ba =
  stmara_eks_item_1.itemid
WHERE stmara_eks_item.constructed IS NULL
 AND stmara_eks_item.zactive = 1
 AND stmara_eks_item.zlegacymatkl IS NOT NULL
ORDER BY ba_item_no NULLS LAST;