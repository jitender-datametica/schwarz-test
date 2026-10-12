CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zz_pack_content_updsel_2 (itemid, zzz_pack_content,
zzz_pack_contentnew) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zzz_pack_content,
 itemdetail.volume AS zzz_pack_contentnew
FROM idq_production_eks_calculation.stmara_eks_item_2
 INNER JOIN idq_production_eks.itemdetail_2 ON stmara_eks_item.itemid = itemdetail.itemid;