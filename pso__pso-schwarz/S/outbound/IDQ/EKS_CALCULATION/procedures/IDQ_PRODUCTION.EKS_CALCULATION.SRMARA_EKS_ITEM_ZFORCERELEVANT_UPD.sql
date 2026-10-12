CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zforcerelevant_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zforcerelevant = SR.zforcerelevantnew FROM eks_calculation.srmara_eks_item_zforcerelevant_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




