CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zz_pack_cont_uom_article_type_ea_updsel (itemid,
zlegacyzz_pack_cont_uom, zlegacyzz_pack_cont_uomnew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.zlegacyzz_pack_cont_uom,
 steks_translation_int_unit.description AS zlegacyzz_pack_cont_uomnew
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.itemdetail ON stmara_eks_item.itemid = itemdetail.itemid
 INNER JOIN idq_production_eks.unit ON itemdetail.unitid = unit.unitid
 INNER JOIN idq_production_eks_calculation.steks_translation_int_unit ON unit.shortdescid = steks_translation_int_unit.translationid
  
WHERE stmara_eks_item.zlegacyzz_pack_cont_uom IS NULL
 AND stmara_eks_item.bitflag = 0;