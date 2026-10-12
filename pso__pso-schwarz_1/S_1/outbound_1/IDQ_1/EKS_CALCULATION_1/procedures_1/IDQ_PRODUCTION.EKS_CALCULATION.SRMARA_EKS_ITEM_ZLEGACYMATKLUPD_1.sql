CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zlegacymatklupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zlegacymatkl = SR.zlegacymatklnew FROM eks_calculation.srmara_eks_item_zlegacymatklupdsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




