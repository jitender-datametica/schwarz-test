CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_matklupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zmatkl = sr.zmatklnew FROM idq_production_eks_calculation.srmara_eks_item_matklupdsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
