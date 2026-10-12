CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_articlefamily_ea_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_1 SET
    articlefamily = sr.articlefamilynew FROM idq_production_eks_calculation.srmara_eks_item_articlefamily_ea_updsel_1 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
