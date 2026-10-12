CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_matklupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zmatkl = SR.zmatklnew FROM eks_calculation.srmara_eks_item_matklupdsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




