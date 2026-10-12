CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zz_pack_type_article_type_eaupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zlegacyzz_pack_type = sr.zlegacyzz_pack_typenew FROM idq_production_eks_calculation.srmara_eks_item_zz_pack_type_article_type_eaupdsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
