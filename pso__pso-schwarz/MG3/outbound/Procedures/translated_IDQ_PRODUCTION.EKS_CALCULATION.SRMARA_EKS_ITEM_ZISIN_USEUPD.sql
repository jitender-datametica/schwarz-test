CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zisin_useupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item SET
    zisin_use = CAST(srmara_eks_item_zisin_useupdsel.zisin_usenew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_zisin_useupdsel
WHERE stmara_eks_item.itemid = srmara_eks_item_zisin_useupdsel.itemid;
END;
