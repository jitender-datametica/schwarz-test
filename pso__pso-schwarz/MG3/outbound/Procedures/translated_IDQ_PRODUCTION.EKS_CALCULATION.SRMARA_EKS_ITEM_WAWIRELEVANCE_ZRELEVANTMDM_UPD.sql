CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_wawirelevance_zrelevantmdm_upd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zrelevantmdm = sr.zrelevantmdmnew FROM idq_production_eks_calculation.srmara_eks_item_wawirelevance_zrelevantmdm_updsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
