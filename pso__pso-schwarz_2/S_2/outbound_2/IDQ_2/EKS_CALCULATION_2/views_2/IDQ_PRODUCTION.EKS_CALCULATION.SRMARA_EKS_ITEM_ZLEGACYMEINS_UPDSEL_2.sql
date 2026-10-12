CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zlegacymeins_updsel_2 (zlegacymeins, itemid,
zlegacymeinsnew) AS SELECT stmara_eks_item.zlegacymeins,
 stmara_eks_item.itemid,
  CASE
  WHEN stmara_eks_item.znegotiatingcountry = 'AT' OR stmara_eks_item.znegotiatingcountry = 'CH' OR stmara_eks_item.znegotiatingcountry
     = 'DE'
  THEN itemdetail.text_int
  ELSE IFNULL(itemdetail.text_int, itemdetail.text_nat)
  END AS zlegacymeinsnew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itemdetail_2 ON stmara_eks_item.itemid = itemdetail.itemid;