CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zz_pack_type_article_type_eaupdsel_2 (itemid,
zlegacyzz_pack_type, zlegacyzz_pack_typenew) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zlegacyzz_pack_type,
 steks_translation_package.description AS zlegacyzz_pack_typenew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itemdetail_2 ON stmara_eks_item.itemid = itemdetail.itemid
 INNER JOIN idq_production_eks.package_2 ON itemdetail.packageid = package.packageid
 INNER JOIN idq_production_eks_calculation.steks_translation_package_2 ON package.shortdescid = steks_translation_package_2
  .translationid
WHERE stmara_eks_item.zlegacyzz_pack_type IS NULL
 AND stmara_eks_item.bitflag = 0;