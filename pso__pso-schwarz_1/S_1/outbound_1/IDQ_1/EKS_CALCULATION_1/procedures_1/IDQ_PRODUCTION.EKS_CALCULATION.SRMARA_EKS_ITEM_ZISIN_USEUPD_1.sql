CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zisin_useupd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zisin_use = srmara_eks_item_zisin_useupdsel.zisin_usenew FROM eks_calculation.srmara_eks_item_zisin_useupdsel_1
WHERE stmara_eks_item.itemid = srmara_eks_item_zisin_useupdsel.itemid;
END;




