CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_ziscurrentcontract_resetduplicates_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    ziscurrentcontract = SR.ziscurrentcontractnew FROM eks_calculation.srmara_eks_item_ziscurrentcontract_resetduplicates_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




