CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupsk_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_1 SET
    buyerid = SR.buyeridnew,
    buyerfirstname = SR.buyerfirstnamenew,
    buyerlastname = SR.buyerlastnamenew FROM eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupsk_updsel_1 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




