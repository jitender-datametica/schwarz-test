CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zforcenotrelevant_rolluptosk_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zforcenotrelevant = sr.zforcenotrelevantnew FROM idq_production_eks_calculation.srmara_eks_item_zforcenotrelevant_rolluptosk_updsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
