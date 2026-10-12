CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zz_pack_type_article_type_eaupdsel_1 (itemid,
zlegacyzz_pack_type, zlegacyzz_pack_typenew) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zlegacyzz_pack_type,
 steks_translation_package.description AS zlegacyzz_pack_typenew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks.itemdetail_1 ON stmara_eks_item.itemid = itemdetail.itemid
 INNER JOIN idq_production_eks.package_1 ON itemdetail.packageid = package.packageid
 INNER JOIN idq_production_eks_calculation.steks_translation_package_1 ON package.shortdescid = steks_translation_package_1
  .translationid
WHERE stmara_eks_item.zlegacyzz_pack_type IS NULL
 AND stmara_eks_item.bitflag = 0;