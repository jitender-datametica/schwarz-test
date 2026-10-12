CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_01_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_2 SET
    zitem_ba = sr.zitem_banew FROM idq_production_eks_calculation.srmara_eks_item_zitem_ba_article_type_ea_01_updsel_2 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
