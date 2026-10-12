CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_matkl_article_type_ba_updsel_2 (zlegacymatkl, zmatkl
, zlegacymatklnew, zmatklnew, itemid) AS SELECT stmara_eks_item.zlegacymatkl,
 stmara_eks_item.zmatkl,
 srmara_eks_item_matkl_article_type_ba_010.zlegacymatklnew,
 srmara_eks_item_matkl_article_type_ba_010.zmatklnew,
 stmara_eks_item.itemid
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks_calculation.srmara_eks_item_matkl_article_type_ba_010_2 ON stmara_eks_item.itemid =
  srmara_eks_item_matkl_article_type_ba_010.sortitemid
WHERE stmara_eks_item.zmatkl IS NULL
 AND stmara_eks_item.bitflag = 2
 AND stmara_eks_item.zlegacymatkl IS NULL;