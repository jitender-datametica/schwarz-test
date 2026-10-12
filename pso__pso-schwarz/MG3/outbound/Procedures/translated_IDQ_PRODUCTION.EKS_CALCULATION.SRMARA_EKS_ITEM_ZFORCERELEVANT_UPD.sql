CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zforcerelevant_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zforcerelevant = CAST(sr.zforcerelevantnew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_zforcerelevant_updsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
