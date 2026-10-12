CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupmk_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    buyerid = SR.buyeridnew,
    buyerfirstname = SR.buyerfirstnamenew,
    buyerlastname = SR.buyerlastnamenew FROM eks_calculation.srmara_eks_item_buyerid_firstname_lastname_barollupmk_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




