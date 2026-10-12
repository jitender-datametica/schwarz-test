CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_buyerid_firstname_lastname_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    buyerid = SR.buyeridnew,
    buyerfirstname = SR.buyerfirstnamenew,
    buyerlastname = SR.buyerlastnamenew FROM eks_calculation.srmara_eks_item_buyerid_firstname_lastname_updsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




