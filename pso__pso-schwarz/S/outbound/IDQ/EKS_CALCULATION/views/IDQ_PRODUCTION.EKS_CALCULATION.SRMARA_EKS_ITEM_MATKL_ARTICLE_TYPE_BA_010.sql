CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_matkl_article_type_ba_010 (sortitemid,
zlegacymatklnew, zmatklnew) AS SELECT itemsorting.sortitemid,
 MIN(STMARA_EKS_ITEM_1.zmatkl) AS zlegacymatklnew,
 MIN(STMARA_EKS_ITEM_1.zmatkl) AS zmatklnew
FROM idq_production_eks.itemsorting
 INNER JOIN idq_production_eks_calculation.stmara_eks_item AS STMARA_EKS_ITEM_1 ON itemsorting.itemid =
  STMARA_EKS_ITEM_1.itemid
WHERE STMARA_EKS_ITEM_1.bitflag IN (4, 0)
 AND STMARA_EKS_ITEM_1.zmatkl IS NOT NULL
GROUP BY itemsorting.sortitemid;