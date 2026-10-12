CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zz_quant_pack_cont_article_type_eaupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    zzz_quant_pack_cont = CAST(sr.zzz_quant_pack_contnew AS NUMERIC) FROM idq_production_eks_calculation.srmara_eks_item_zz_quant_pack_cont_article_type_eaupdsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
