CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_meins_updsel_2 (zmeins, zmeinsnew, itemid,
zlegacymeins, description) AS SELECT stmara_eks_item.zmeins,
  CASE
  WHEN IFNULL(stmara_eks_item.zlegacymeins, '') = ' '
  THEN 'ST'
  ELSE CASE
   WHEN translation_int.description = 'KG' OR translation_int.description = 'g'
   THEN 'KG'
   WHEN translation_int.description = 'LB' OR translation_int.description = 'oz'
   THEN 'LB'
   ELSE 'KG'
   END
  END AS zmeinsnew,
 stmara_eks_item.itemid,
 stmara_eks_item.zlegacymeins,
 translation_int.description
FROM idq_production_eks_calculation.stmara_eks_item_2
 LEFT JOIN idq_production_eks.itemdetail_2 ON stmara_eks_item.itemid = itemdetail.itemid
 INNER JOIN idq_production_eks.unit_2 ON itemdetail.unitid = unit.unitid
 INNER JOIN idq_production_eks.translation_int_2 ON unit.shortdescid = translation_int.translationid
WHERE stmara_eks_item.bitflag = 0;