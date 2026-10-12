CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_matkl_article_type_ba_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zmatkl = sr.zmatklnew,
    zlegacymatkl = sr.zlegacymatklnew FROM idq_production_eks_calculation.srmara_eks_item_matkl_article_type_ba_updsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
