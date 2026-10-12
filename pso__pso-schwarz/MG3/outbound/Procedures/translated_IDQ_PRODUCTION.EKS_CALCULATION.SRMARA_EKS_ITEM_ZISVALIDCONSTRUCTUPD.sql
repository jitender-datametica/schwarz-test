CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zisvalidconstructupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zisvalidconstruct = CAST(sr.zisvalidconstructnew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_zisvalidconstructupdsel AS sr
WHERE stmara_eks_item.itemid = sr.itemid;
END;
