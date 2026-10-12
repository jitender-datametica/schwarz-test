CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_begru_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zbegru = SR.zbegrunew FROM eks_calculation.srmara_eks_item_begru_updsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




