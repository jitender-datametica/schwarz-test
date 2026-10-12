CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_matkl_article_type_sk_010 (zlegacymatnr,
zlegacymatkl, zmatkl, zlegacymatklnew, zmatklnew) AS SELECT stmara_eks_item.zlegacymatnr,
 stmara_eks_item.zlegacymatkl,
 stmara_eks_item.zmatkl,
 MIN(STMARA_EKS_ITEM_1.zmatkl) AS zlegacymatklnew,
 MIN(STMARA_EKS_ITEM_1.zmatkl) AS zmatklnew
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.itemsorting ON stmara_eks_item.itemid = itemsorting.sortitemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS STMARA_EKS_ITEM_1 ON itemsorting.itemid =
  STMARA_EKS_ITEM_1.itemid
WHERE stmara_eks_item.zmatkl IS NULL
 AND stmara_eks_item.bitflag = 4
 AND STMARA_EKS_ITEM_1.bitflag = 0
 AND STMARA_EKS_ITEM_1.zmatkl IS NOT NULL
GROUP BY stmara_eks_item.zlegacymatnr,
 stmara_eks_item.zlegacymatkl,
 stmara_eks_item.zmatkl;