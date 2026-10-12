CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zarticletypeupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    zarticletype = SR.zarticletypenew FROM eks_calculation.srmara_eks_item_zarticletypeupdsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




