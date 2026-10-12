CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_matkl_article_type_eaupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    zmatkl = sr.zmatklnew FROM idq_production_eks_calculation.srmara_eks_item_matkl_article_type_eaupdsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
