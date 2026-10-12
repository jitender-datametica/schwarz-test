CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zlegacymatklupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_2 SET
    zlegacymatkl = sr.zlegacymatklnew FROM idq_production_eks_calculation.srmara_eks_item_zlegacymatklupdsel_2 AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
