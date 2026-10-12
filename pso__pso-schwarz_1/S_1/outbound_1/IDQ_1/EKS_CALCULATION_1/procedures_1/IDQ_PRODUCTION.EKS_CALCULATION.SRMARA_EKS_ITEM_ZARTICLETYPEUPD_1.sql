CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zarticletypeupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zarticletype = SR.zarticletypenew FROM eks_calculation.srmara_eks_item_zarticletypeupdsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




