CREATE OR REPLACE VIEW idq_production_eks_calculation.srmara_eks_item_zz_quant_pack_cont_article_type_eaupdsel (itemid,
zzz_quant_pack_cont, zzz_quant_pack_contnew) AS SELECT stmara_eks_item.itemid,
 stmara_eks_item.zzz_quant_pack_cont,
 itemdetail.bundlefact AS zzz_quant_pack_contnew
FROM idq_production_eks_calculation.stmara_eks_item
 INNER JOIN idq_production_eks.itemdetail ON stmara_eks_item.itemid = itemdetail.itemid
WHERE stmara_eks_item.zzz_quant_pack_cont IS NULL
 AND stmara_eks_item.bitflag = 0;