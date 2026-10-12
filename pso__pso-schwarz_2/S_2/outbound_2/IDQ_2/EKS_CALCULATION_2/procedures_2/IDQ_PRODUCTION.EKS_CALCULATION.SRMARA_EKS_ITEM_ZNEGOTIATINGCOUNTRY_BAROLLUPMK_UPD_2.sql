CREATE OR REPLACE PROCEDURE eks_calculation.srmara_eks_item_znegotiatingcountry_barollupmk_upd()
BEGIN
UPDATE eks_calculation.stmara_eks_item_2 SET
    znegotiatingcountry = SR.znegotiatingcountrynew FROM eks_calculation.srmara_eks_item_znegotiatingcountry_barollupmk_updsel_2 AS SR
WHERE stmara_eks_item.itemid = SR.itemid;
END;




