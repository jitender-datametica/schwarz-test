CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontractfromsk_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    ziscurrentcontractfromsk = SR.ziscurrentcontractfromsknew FROM eks_calculation.srmara_eks_item_wawirelevance_ziscurrentcontractfromsk_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




