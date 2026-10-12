CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_matkl_article_type_eaupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zmatkl = SR.zmatklnew FROM eks_calculation.srmara_eks_item_matkl_article_type_eaupdsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




