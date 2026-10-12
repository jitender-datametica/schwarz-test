CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    ziscurrentcontractfromsk = SR.ziscurrentcontractfromsknew FROM eks_calculation.srmara_eks_item_ziscurrentcontractfromsk_updsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




