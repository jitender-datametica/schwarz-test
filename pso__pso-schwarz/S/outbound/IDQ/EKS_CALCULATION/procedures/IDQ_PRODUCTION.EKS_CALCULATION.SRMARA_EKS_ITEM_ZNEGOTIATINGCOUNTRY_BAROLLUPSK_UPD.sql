CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_znegotiatingcountry_barollupsk_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item SET
    znegotiatingcountry = SR.znegotiatingcountrynew FROM eks_calculation.srmara_eks_item_znegotiatingcountry_barollupsk_updsel AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




