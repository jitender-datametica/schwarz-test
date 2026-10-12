CREATE OR REPLACE PROCEDURE idq_production_eks_calculation.srmara_eks_item_zisin_useupd()
BEGIN
UPDATE idq_production_eks_calculation.stmara_eks_item_2 SET
    zisin_use = CAST(srmara_eks_item_zisin_useupdsel.zisin_usenew AS INTEGER) FROM idq_production_eks_calculation.srmara_eks_item_zisin_useupdsel_2
WHERE stmara_eks_item.itemid = srmara_eks_item_zisin_useupdsel.itemid;
END;
