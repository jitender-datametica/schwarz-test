CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_matkl_article_type_sk_010_1 (zlegacymatnr,
zlegacymatkl, zmatkl, zlegacymatklnew, zmatklnew) AS SELECT stmara_eks_item.zlegacymatnr,
 stmara_eks_item.zlegacymatkl,
 stmara_eks_item.zmatkl,
 MIN(stmara_eks_item_1.zmatkl) AS zlegacymatklnew,
 MIN(stmara_eks_item_1.zmatkl) AS zmatklnew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.itemsorting_1 ON stmara_eks_item.itemid = itemsorting.sortitemid
 INNER JOIN idq_production_eks_calculation.stmara_eks_item_1 AS stmara_eks_item_1 ON itemsorting.itemid =
  stmara_eks_item_1.itemid
WHERE stmara_eks_item.zmatkl IS NULL
 AND stmara_eks_item.bitflag = 4
 AND stmara_eks_item_1.bitflag = 0
 AND stmara_eks_item_1.zmatkl IS NOT NULL
GROUP BY stmara_eks_item.zlegacymatnr,
 stmara_eks_item.zlegacymatkl,
 stmara_eks_item.zmatkl;