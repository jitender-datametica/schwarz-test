CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_zitem_ba_constructedbaforea_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    zitem_ba = SR.zitem_banew FROM eks_calculation.srmara_eks_item_zitem_ba_constructedbaforea_updsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




