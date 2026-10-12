CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zhasvalidtimelinelu_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zhasvalidtimelinelu = SR.zhasvalidtimelinelunew FROM eks_calculation.srmara_eks_item_zhasvalidtimelinelu_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




