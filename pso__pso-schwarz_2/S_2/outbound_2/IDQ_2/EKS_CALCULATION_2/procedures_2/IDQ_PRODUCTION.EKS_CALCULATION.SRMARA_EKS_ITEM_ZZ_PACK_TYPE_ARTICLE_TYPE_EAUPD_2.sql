CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zz_pack_type_article_type_eaupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    zlegacyzz_pack_type = SR.zlegacyzz_pack_typenew FROM eks_calculation.srmara_eks_item_zz_pack_type_article_type_eaupdsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




