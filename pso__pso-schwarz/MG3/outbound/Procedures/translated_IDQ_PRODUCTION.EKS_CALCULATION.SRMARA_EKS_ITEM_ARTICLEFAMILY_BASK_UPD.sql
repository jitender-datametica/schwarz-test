CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_articlefamily_bask_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    articlefamily = sr.articlefamilynew FROM idq_production_eks_calculation.srmara_eks_item_articlefamily_bask_updsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
