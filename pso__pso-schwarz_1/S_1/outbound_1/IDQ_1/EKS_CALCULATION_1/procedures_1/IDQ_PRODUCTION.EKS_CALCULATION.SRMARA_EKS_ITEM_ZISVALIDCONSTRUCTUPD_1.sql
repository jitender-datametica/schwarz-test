CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zisvalidconstructupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zisvalidconstruct = SR.zisvalidconstructnew FROM eks_calculation.srmara_eks_item_zisvalidconstructupdsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




