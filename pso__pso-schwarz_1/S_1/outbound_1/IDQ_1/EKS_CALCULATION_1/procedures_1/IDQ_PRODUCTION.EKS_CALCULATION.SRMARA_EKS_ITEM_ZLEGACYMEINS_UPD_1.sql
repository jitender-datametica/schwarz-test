CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zlegacymeins_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zlegacymeins = SR.zlegacymeinsnew FROM eks_calculation.srmara_eks_item_zlegacymeins_updsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




