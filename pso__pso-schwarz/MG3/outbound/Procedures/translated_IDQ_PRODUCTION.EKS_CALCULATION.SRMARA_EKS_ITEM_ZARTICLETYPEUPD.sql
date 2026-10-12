CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zarticletypeupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zarticletype = sr.zarticletypenew FROM idq_production_eks_calculation.srmara_eks_item_zarticletypeupdsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
