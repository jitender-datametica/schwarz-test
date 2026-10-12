CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_zzz_pack_cont_uom_fromxtt006updsel_1 (itemid,
zzz_pack_cont_uom, zzz_pack_cont_uomnew) AS SELECT DISTINCT stmara_eks_item.itemid,
 stmara_eks_item.zzz_pack_cont_uom,
 xtt006_eks_eks_mm_zsm.targetvalue1 AS zzz_pack_cont_uomnew
FROM idq_production_eks_calculation.stmara_eks_item_1
 INNER JOIN idq_production_eks_calculation.xtt006_eks_eks_mm_zsm_1 ON stmara_eks_item.zlegacyzz_pack_cont_uom =
  xtt006_eks_eks_mm_zsm.legacyvalue
WHERE stmara_eks_item.zzz_pack_cont_uom IS NULL
 AND xtt006_eks_eks_mm_zsm.notrelevant = 0
 AND xtt006_eks_eks_mm_zsm.targetvalue IS NOT NULL;