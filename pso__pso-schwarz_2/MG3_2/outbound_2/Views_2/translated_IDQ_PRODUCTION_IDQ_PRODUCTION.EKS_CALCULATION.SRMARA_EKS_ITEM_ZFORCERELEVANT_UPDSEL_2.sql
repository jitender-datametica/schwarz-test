CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zforcerelevant_updsel_2 (itemid, zforcerelevant,
zforcerelevantnew, itemno) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zforcerelevant,
 eks_zsm_articlerelevancyoverride.forcerelevant AS zforcerelevantnew,
 eks_zsm_articlerelevancyoverride.itemno
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks_calculation.eks_zsm_articlerelevancyoverride_2 ON stmara_eks_item.zsource =
   eks_zsm_articlerelevancyoverride.zsource AND stmara_eks_item.itemno = CAST(eks_zsm_articlerelevancyoverride.itemno AS FLOAT64)
   
WHERE eks_zsm_articlerelevancyoverride.forcerelevant = 1
 OR stmara_eks_item.zforcerelevant <> eks_zsm_articlerelevancyoverride.forcerelevant;