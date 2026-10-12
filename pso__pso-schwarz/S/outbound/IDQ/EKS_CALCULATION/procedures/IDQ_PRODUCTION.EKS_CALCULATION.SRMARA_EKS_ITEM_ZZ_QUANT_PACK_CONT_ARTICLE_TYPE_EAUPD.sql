CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zz_quant_pack_cont_article_type_eaupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zzz_quant_pack_cont = CAST(SR.zzz_quant_pack_contnew AS NUMERIC) FROM eks_calculation.srmara_eks_item_zz_quant_pack_cont_article_type_eaupdsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




