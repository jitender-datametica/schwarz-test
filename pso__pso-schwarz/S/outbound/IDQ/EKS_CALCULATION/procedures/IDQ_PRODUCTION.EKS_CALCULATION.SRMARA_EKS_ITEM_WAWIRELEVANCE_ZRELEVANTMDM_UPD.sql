CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_wawirelevance_zrelevantmdm_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zrelevantmdm = SR.zrelevantmdmnew FROM eks_calculation.srmara_eks_item_wawirelevance_zrelevantmdm_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




