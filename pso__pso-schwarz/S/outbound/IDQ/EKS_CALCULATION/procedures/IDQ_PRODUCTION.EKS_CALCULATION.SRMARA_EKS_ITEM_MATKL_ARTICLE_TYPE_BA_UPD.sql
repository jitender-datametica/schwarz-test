CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_matkl_article_type_ba_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zmatkl = SR.zmatklnew,
    zlegacymatkl = SR.zlegacymatklnew FROM eks_calculation.srmara_eks_item_matkl_article_type_ba_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




