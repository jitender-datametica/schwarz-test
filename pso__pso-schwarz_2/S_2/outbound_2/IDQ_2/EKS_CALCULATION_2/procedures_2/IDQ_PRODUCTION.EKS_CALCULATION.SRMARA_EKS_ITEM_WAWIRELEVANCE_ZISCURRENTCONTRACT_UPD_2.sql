CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontract_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    ziscurrentcontract = SR.ziscurrentcontractnew FROM eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontract_updsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




